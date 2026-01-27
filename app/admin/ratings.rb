ActiveAdmin.register Rating do
  permit_params :rating, :user_id, :movie_id, :created_at, :updated_at

  # ❌ disable automatic filters
  config.filters = false

  index do
    selectable_column
    id_column
    column :rating
    column :user_id
    column :movie_id
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :rating
      f.input :user_id
      f.input :movie_id
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :rating, :user_id, :movie_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:rating, :user_id, :movie_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
