class UserAchievementSerializer < ActiveModel::Serializer
  attributes :id, :current, :total
  attributes :completed_at, :situation, :score
  attributes :created_at, :updated_at
  attributes :user_id

  attribute :completed do
    object.completed.present? ? object.completed : false
  end

  belongs_to :achievement
  
end
