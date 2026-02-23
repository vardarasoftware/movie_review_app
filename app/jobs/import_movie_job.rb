class ImportMovieJob < ApplicationJob
  queue_as :default

  def perform(import_id, admin_user_id)
    import = Import.find(import_id)
    admin  = User.find(admin_user_id)

    Rails.logger.info "🎬 Starting movie import for Import ##{import.id}"

    import.update(status: "processing", start_at: Time.current)

    unless import.file.attached?
      import.update(status: "failed", meta: { error: "No CSV file attached" })
      return
    end

    require "csv"
    csv_data = import.file.download
    rows = CSV.parse(csv_data, headers: true)

    import.update(total_rows: rows.size)

    success_count = 0
    skipped_count = 0
    failed_count  = 0

    rows.each_with_index do |row, index|
      begin
        title        = row["title"]&.strip
        description  = row["description"]
        release_date = row["release_date"]
        poster_url   = row["poster_url"]
        author       = row["author"]
        writer       = row["writer"]
        genre_name   = row["genre"]&.strip

        if title.blank?
          failed_count += 1
          Rails.logger.warn "❌ Row #{index + 1}: title is blank"
          next
        end

        # Skip duplicates (idempotency rule)
        if Movie.exists?(title: title)
          skipped_count += 1
          Rails.logger.info "⏭️ Row #{index + 1}: skipped duplicate movie '#{title}'"
          next
        end

        # Resolve genre (required by validation)
        genre = Genre.find_by(name: genre_name)
        if genre.nil?
          failed_count += 1
          Rails.logger.warn "❌ Row #{index + 1}: genre '#{genre_name}' not found"
          next
        end

        movie = Movie.new(
          title: title,
          description: description,
          release_date: release_date,
          poster_url: poster_url,
          author: author,
          writer: writer,
          genre: genre,
          user: admin # satisfy presence validation
        )

        if movie.save
          success_count += 1
        else
          failed_count += 1
          Rails.logger.warn "❌ Row #{index + 1}: #{movie.errors.full_messages.join(', ')}"
        end
      rescue => e
        failed_count += 1
        Rails.logger.error "🔥 Row #{index + 1} crashed: #{e.message}"
      end
    end

    import.update(
      status: "completed",
      finished_at: Time.current,
      meta: {
        success: success_count,
        skipped: skipped_count,
        failed: failed_count
      }
    )

    Rails.logger.info "✅ Import ##{import.id} finished. Success: #{success_count}, Skipped: #{skipped_count}, Failed: #{failed_count}"
  rescue => e
    Rails.logger.error "🔥 Import job failed for Import ##{import_id}: #{e.message}"
    import.update(status: "failed", meta: { error: e.message }) if import
    raise e # allow Sidekiq retry
  end
end