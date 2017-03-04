class Achievement < ApplicationRecord
  has_many :user_achievements
  has_many :users, through: :user_achievements
  serialize :conditions, JSON

  TYPE_AMOUNT     = 'amount'
  TYPE_SUBJECT    = 'subject'
  TYPE_CONTINUOUS = 'continuous'

  before_create do
    self.conditions = {} if self.conditions.blank?
  end
end
