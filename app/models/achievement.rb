class Achievement < ApplicationRecord
  has_many :user_achievements
  has_many :users, through: :user_achievements
  serialize :conditions, JSON

  TYPE_AMOUNT     = 'amount'
  TYPE_SUBJECT    = 'subject'
  TYPE_CONTINUOUS = 'continuous'

  AMOUNT_TYPE = {
    :like => 'like',
    :blog => 'blog',
    :accepted => 'accepted',
    :comment => 'comment',
    :cf_rating => 'cf_rating'
  }

  scope :by_type, ->(type) { where(achievement_type: type) }

  before_create do
    self.conditions = {} if self.conditions.blank?
  end

end
