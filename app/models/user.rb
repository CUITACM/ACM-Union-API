class User < ApplicationRecord
  has_secure_password

  has_many :articles
  mount_uploader :avatar, AvatarUploader
  before_create :generate_access_token

  ACTIVE_STATUS = {
    applying: 0,
    training: 1,
    retired: 2
  }

  scope :applying, -> { where(active: ACTIVE_STATUS[:applying]) }
  scope :training, -> { where(active: ACTIVE_STATUS[:training]) }
  scope :retired, -> { where(active: ACTIVE_STATUS[:retired]) }
  scope :admin, -> { where("role >= 4") }

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
