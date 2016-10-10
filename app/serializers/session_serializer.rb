class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :gender, :description
  attributes :role, :status, :token

  attribute :avatar do
    {
        origin: object.avatar.url,
        thumb: object.avatar.thumb.url
    }
  end

  def token
    object.access_token
  end

  attribute :timestamp do
    DateTime.now.to_i
  end

  has_one :user_info do
    object.user_info
  end
end
