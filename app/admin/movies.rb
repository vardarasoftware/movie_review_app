ActiveAdmin.register Movie do
  permit_params :title, :description, :rating, :genre_id, :avatar, :author, :writer

  config.filters = true

  filter :title_cont, label: "Search (Title)"



  # REQUIRED for ActiveStorage images
  controller do
    include Rails.application.routes.url_helpers
  end

  filter :genre
  filter :ratings_rating_gteq,
       as: :select,
       label: "Minimum Rating",
       collection: [
         ["⭐ 1+", 1],
         ["⭐ 2+", 2],
         ["⭐ 3+", 3],
         ["⭐ 4+", 4],
         ["⭐ 5", 5]
       ]
 # filter :ratings_rating, as: :numeric, label: "Rating"

  index do
    selectable_column
    id_column

    column :title
    column "Rating" do |movie|
      if movie.average_rating.present?
          "⭐" * movie.average_rating.to_i

        else
         "No rating"
        end
      end

    column "Reviews" do |movie|
      if movie.reviews.any?
         movie.reviews.last.body
        else
          "No Review"
        end
      end

    column "Genre" do |movie|
      movie.genre&.name || "No Genre"
    end

    column :author

    column :writer


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
      row :description
      row "Rating" do |movie|
        if movie.average_rating.present?
          "⭐" * movie.average_rating.to_i
          else
            "No rating"
          end
        end

      row "Genre" do |moive|
        movie.genre&.name || "No Genre"
      end

      row :author
      row :writer


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
      f.input :description
      f.input :genre, as: :select, collection: Genre.all.map { |g| [g.name, g.id] }
      f.input :author
      f.input :writer
      f.input :avatar, as: :file
    end
    f.actions
  end
end
