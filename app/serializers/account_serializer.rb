class AccountSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :oj_name, :solved, :submitted, :status
  attributes :user_id

  attribute :updated_at do
    object.updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
