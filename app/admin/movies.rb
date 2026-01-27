ActiveAdmin.register Movie do
  permit_params :title, :discription, :genre_id, :avatar

  config.filters = false

  # REQUIRED for ActiveStorage images
  controller do
    include Rails.application.routes.url_helpers
  end

  index do
    selectable_column
    id_column

    column :title
    column :discription
    column :genre_id
    column :created_at

    column "Poster" do |movie|
      if movie.avatar.attached?
        image_tag url_for(movie.avatar), size: "300x300"
      else
        "No Image"
      end
    end

    actions
  end

  show do
    attributes_table do
      row :title
      row :discription
      row :genre_id

      row "Poster" do |movie|
        if movie.avatar.attached?
          image_tag url_for(movie.avatar), size: "600x500"
        else
          "No Image"
        end
      end

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :discription
      f.input :genre_id
      f.input :avatar, as: :file
    end
    f.actions
  end
end
