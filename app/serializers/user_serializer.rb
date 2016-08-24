class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :nickname, :token

  def token
    object.access_token
  end
end
