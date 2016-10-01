class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :filename, :path, :usage, :description, :owner
  attributes :created_at, :auth
end
