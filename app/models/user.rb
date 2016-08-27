class User < ApplicationRecord
  has_many :articles

  has_secure_password
  before_create :generate_access_token

  def generate_access_token
    loop do
      self.access_token = SecureRandom.base64(64)
      break unless User.find_by(:access_token => access_token)
    end
  end

  def reset_access_token
    generate_access_token
    save
  end
end
