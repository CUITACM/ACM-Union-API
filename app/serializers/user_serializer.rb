class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :display_name, :gender, :description
  attributes :role, :status

  attribute :avatar do
    { origin: object.avatar.url, thumb: object.avatar.thumb.url }
  end

  attribute :created_at do
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  attribute :is_admin do
    object.role == 4
  end

  has_one :user_info do
    object.user_info || {}
  end

end
