class Submit < ApplicationRecord

  ACCEPTED_KEYS = ['Accepted', 'AC', 'OK']

  def self.search_columns
    [:user_name]
  end

  def self.user_accepted(user_id)
    self.where(user_id: user_id, result: ACCEPTED_KEYS)
  end

end
