class AchievementsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :score
  attributes :achievement_type
  attributes :conditions


end
