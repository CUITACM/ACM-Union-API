class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :display_name, :gender, :description
  attributes :role, :status

  attribute :avatar do
    {
        origin: object.avatar.url,
        thumb: object.avatar.thumb.url
    }
  end

  has_one :user_info do
    object.user_info || {}
  end

end
