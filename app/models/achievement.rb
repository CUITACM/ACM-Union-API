class Achievement < ApplicationRecord
  has_many :user_achievements
  has_many :users, through: :user_achievements

  TYPE_AMOUNT     = 'amount'
  TYPE_SUBJECT    = 'subject'
  TYPE_CONTINUOUS = 'continuous'

end
