ActiveAdmin.register Import do
  config.filters = false

  permit_params :filename, :size, :file_type, :total_rows, :start_at, :finished_at, :meta, :file

  index do
    selectable_column
    id_column
    column :filename
    column :total_rows
    column :start_at
    column :finished_at

    column "CSV File" do |import|
      if import.file.attached?
        link_to import.file.filename.to_s,
                rails_blob_path(import.file, disposition: "attachment")
      else
        "No file"
      end
    end

    column :created_at
    actions
  end

  form do |f|
    f.inputs "Upload CSV" do
      f.input :filename
      f.input :file, as: :file
      f.input :file_type, as: :select, collection: Import.file_types.keys
    end
    f.actions
  end

  ## controllers
    controller do
    def create
      @import = Import.new(permitted_params[:import])

      if @import.save
        ImportMovieJob.perform_later(@import.id, 95)

        redirect_to admin_import_path(@import), notice: "Import created and CSV uploaded successfully."
      else
        flash.now[:error] = @import.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
    end
  end
end
