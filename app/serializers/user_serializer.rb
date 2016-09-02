class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :avatar, :gender, :stu_id
  attributes :email, :phone, :school, :college, :major, :grade
  attributes :role, :active

end
