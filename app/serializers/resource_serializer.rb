class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :filename, :usage, :description, :owner
  attributes :auth

  attribute :file do
    { origin: object.file.url, thumb: object.file.thumb.url }
  end

  attribute :file_size do
    ActiveSupport::NumberHelper.number_to_human_size(File.size(object.file.current_path))
  end

  attribute :created_at do
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
