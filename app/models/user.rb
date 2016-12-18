class User < ApplicationRecord
  # concern & mixin
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  # relations
  has_one :user_info, dependent: :destroy
  has_many :articles
  has_many :accounts

  # User status def
  STATUS_REJECT = -1    # 拒绝申请
  STATUS_APPLY  = 0     # 申请
  STATUS_TRAIN  = 1     # 训练
  STATUS_RETIRE = 2     # 退役

  ROLE_STUDENT  = 1     # 学生
  ROLE_COACH    = 2     # 教练
  ROLE_ADMIN    = 4     # 管理员

  # scope
  scope :student, -> { where(role: ROLE_STUDENT) }
  scope :coach, -> { where(role: ROLE_STUDENT) }
  scope :manager, -> { where(role: ROLE_ADMIN) }


  def self.search_columns
    [:nickname, :display_name, :description]
  end

  def super_admin?
    self.role == ROLE_ADMIN
  end

  def admin?
    self.super_admin? || self.role == ROLE_COACH
  end

  def token(exp)
    JsonWebToken.encode({ user_id: self.id }, exp)
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
