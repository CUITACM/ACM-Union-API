class User < ApplicationRecord
  # concern & mixin
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  # relations
  has_one :user_info, dependent: :destroy
  has_many :articles

  # User status def
  STATUS_APPLY = 0    # 申请
  STATUS_TRAIN = 1    # 训练
  STATUS_RETIRE = 2   # 退役

  # scope
  scope :admin, -> { where("role >= 4") }

  # models callback
  before_create :generate_access_token

  def search_columns
    [:name, :nickname, :email]
  end

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

  def update_user_info(params)
    @user_info = self.user_info
    if @user_info.blank?
      @user_info = self.build_user_info
    end
    filter_params = params.permit!.slice(
        :email, :stu_id, :phone, :school, :college,
        :major, :grade, :situation
    )
    p filter_params.inspect
    @user_info.assign_attributes(filter_params)
    @user_info.save
  end

end
