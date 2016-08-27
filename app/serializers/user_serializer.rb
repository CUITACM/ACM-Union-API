class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :nickname, :gender, :avatar

end
