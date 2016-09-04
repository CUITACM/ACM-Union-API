class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :avatar, :gender, :stu_id
  attributes :email, :phone, :school, :college, :major, :grade
  attributes :role, :status

  attribute :created_at do
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

end
