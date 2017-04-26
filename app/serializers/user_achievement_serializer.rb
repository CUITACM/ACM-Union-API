class UserAchievementSerializer < ActiveModel::Serializer
  attributes :id, :current, :total
  attributes :completed, :completed_at, :situation, :score
  attributes :created_at, :updated_at
  attributes :user_id

  belongs_to :achievement
  
end
