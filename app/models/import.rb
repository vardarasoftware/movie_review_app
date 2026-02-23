class Import < ApplicationRecord
  has_one_attached :file
  enum file_type: { csv: 0, excel: 1, json: 2 }

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      filename
      size
      file_type
      total_rows
      start_at
      finished_at
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []   
  end
end
