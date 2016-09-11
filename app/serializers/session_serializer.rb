class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :gender, :stu_id
  attributes :email, :phone, :school, :college, :major, :grade
  attributes :role, :status, :token

  attribute :avatar do
    object.avatar.url
  end

  def token
    object.access_token
  end

  attribute :timestamp do
    DateTime.now.to_i
  end
end
