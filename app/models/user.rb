class User < ApplicationRecord
  has_secure_password

  has_many :articles
  mount_uploader :avatar, AvatarUploader
  before_create :generate_access_token

  STATUS_APPLY = 0    # 申请
  STATUS_TRAIN = 1    # 训练
  STATUS_RETIRE = 2   # 退役

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
