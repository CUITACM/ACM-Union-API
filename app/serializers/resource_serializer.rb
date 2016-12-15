class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :filename, :usage, :description, :owner_id
  attributes :auth

  attribute :path do
    { origin: object.path.url, thumb: object.path.thumb.url }
  end

  attribute :file_size do
    ActiveSupport::NumberHelper.number_to_human_size(File.size(object.path.current_path))
  end

  attribute :created_at do
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
