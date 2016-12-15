class SubmitSerializer < ActiveModel::Serializer
  attributes :id, :pro_id, :run_id, :run_time, :memory, :lang, :result, :submitted_at
  attributes :oj_name, :origin_oj, :user_id, :user_name
  attribute :status
  attribute :code

  attribute :updated_at do
    object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end

end
