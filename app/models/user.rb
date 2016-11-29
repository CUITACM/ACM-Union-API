class User < ApplicationRecord
  # concern & mixin
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  # relations
  has_one :user_info, dependent: :destroy
  has_many :articles

  # User status def
  STATUS_REJECT = -1
  STATUS_APPLY  = 0    # 申请
  STATUS_TRAIN  = 1    # 训练
  STATUS_RETIRE = 2   # 退役

  # scope
  scope :admin, -> { where("role >= 4") }

  def search_columns
    [:name, :nickname, :email]
  end

  def token
    JsonWebToken.encode(user_id: self.id)
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
