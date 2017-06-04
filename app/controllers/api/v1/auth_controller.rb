class Api::V1::AuthController < ApplicationController

  def token
    requires! :nickname
    requires! :password

    ident = login_params[:nickname]
    if ident.blank?
      raise ActionController::ParameterMissing.new(:nickname)
    end

    user = User.find_by(nickname: ident)
    if user.blank?
      user_info = UserInfo.find_by('email = ? OR stu_id = ?', ident, ident)
      user = user_info.user if user_info.present?
    end
    if user.present? && user.authenticate(login_params[:password])
      if user.status == User::STATUS_APPLY || user.status == User::STATUS_REJECT
        render json: { error: 1, message: '非法用户' } and return
      end
      expires = AcmUnionApi::TOKEN_EXPIRES
      render json: { token: user.token(expires), expire_time: expires }
    else
      error!({ messgae: '密码错误' })
    end
  end

  def register
    requires! :display_name
    requires! :nickname
    requires! :password
    requires! :description

    exist_user = User.find_by(nickname: register_params[:nickname])
    if exist_user.present?
      render json: { error: 1, messgae: '该用户名已存在' } and return
    end

    if User.create(register_params)
      render json: { error: 0 }
    else
      error!({ error: 1, messgae: '注册失败' })
    end

  end

  private

  def login_params
    params.permit(:nickname, :password)
  end

  def register_params
    params.permit(:display_name, :nickname, :password, :gender, :description)
  end

end
