class HonorSerializer < ActiveModel::Serializer
  attributes :id, :contest_name, :contest_level
  attributes :team_name, :description

  attribute :contest_level do
    object.contest_level.try(:to_s)
  end

  attribute :created_at do
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  attribute :updated_at do
    object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  attribute :images do
    object.images.map { |image| {origin: image.url, thumb: image.thumb.url} }
  end
end
