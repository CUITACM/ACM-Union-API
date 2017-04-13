class UserAchievement < ApplicationRecord

  serialize :situation, JSON

  belongs_to :user
  belongs_to :achievement

  def self.by_owner(achieve_id, user_id)
    self.find_or_initialize_by(
      achievement_id: achieve_id,
      user_id: user_id
    )
  end

end
