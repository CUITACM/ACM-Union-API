class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :avatar, :gender, :stu_id
  attributes :email, :phone, :school, :college, :major, :grade
  attributes :role, :active, :token

  def token
    object.access_token
  end
end
