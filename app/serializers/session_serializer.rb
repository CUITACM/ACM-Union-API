class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :token

  def token
    object.access_token
  end
end
