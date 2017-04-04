class AccountSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :oj_name, :solved, :submitted, :status

  attribute :user do
    { id: object.user.id, name: object.user.display_name }
  end

  attribute :updated_at do
    object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end

end
