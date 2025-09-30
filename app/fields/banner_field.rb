require "administrate/field/base"

class BannerField < Administrate::Field::Base
  def to_s
    data
  end

  def image_url
    return nil unless data.attached?
    Rails.application.routes.url_helpers.rails_blob_path(data, only_path: true)
  end

  def attached?
    data.attached?
  end

  def filename
    data.filename.to_s if data.attached?
  end
end
