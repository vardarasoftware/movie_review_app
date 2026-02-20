require "csv"

module Parser
  class MovieCsvImporter
    EXPECTED_HEADERS = %w[title description release_date poster_url author writer genre].freeze

    def initialize(csv_data, user)
      @csv_data = csv_data
      @user     = user
    end

    def call
      rows = CSV.parse(@csv_data, headers: true)
      validate_headers!(rows.headers)

      success = 0
      skipped = 0
      failed  = 0

      rows.each_with_index do |row, idx|
        begin
          attrs = normalize_row(row)

          if attrs[:title].blank?
            failed += 1
            Rails.logger.warn("Row #{idx + 1}: title is blank")
            next
          end

          # Idempotency: skip duplicates by title
          if Movie.exists?(title: attrs[:title])
            skipped += 1
            Rails.logger.info("Row #{idx + 1}: skipped duplicate '#{attrs[:title]}'")
            next
          end

          genre = Genre.find_by(name: attrs[:genre])
          unless genre
            failed += 1
            Rails.logger.warn("Row #{idx + 1}: genre '#{attrs[:genre]}' not found")
            next
          end

          movie = Movie.new(
            title:        attrs[:title],
            description:  attrs[:description],
            release_date: attrs[:release_date],
            poster_url:   attrs[:poster_url],
            author:       attrs[:author],
            writer:       attrs[:writer],
            genre:        genre,
            user:         @user
          )

          if movie.save
            success += 1
          else
            failed += 1
            Rails.logger.warn("Row #{idx + 1}: #{movie.errors.full_messages.join(', ')}")
          end
        rescue => e
          failed += 1
          Rails.logger.error("Row #{idx + 1} crashed: #{e.class} - #{e.message}")
        end
      end

      {
        total:   rows.size,
        success: success,
        skipped: skipped,
        failed:  failed
      }
    end

    private

    def validate_headers!(headers)
      normalized = headers.map { |h| h.to_s.strip.downcase }
      missing = EXPECTED_HEADERS - normalized
      if missing.any?
        raise ArgumentError, "CSV headers invalid. Missing: #{missing.join(', ')}"
      end
    end

    def normalize_row(row)
      h = row.to_h.transform_keys { |k| k.to_s.strip.downcase }
      {
        title:        h["title"]&.strip,
        description:  h["description"],
        release_date: h["release_date"],
        poster_url:   h["poster_url"],
        author:       h["author"],
        writer:       h["writer"],
        genre:        h["genre"]&.strip
      }
    end
  end
end