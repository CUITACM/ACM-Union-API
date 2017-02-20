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
      expires = AcmUnionApi::TOKEN_EXPIRES
      render json: { token: user.token(expires), expire_time: expires }
    else
      error!({ messgae: '密码错误' })
    end
  end

  private

  def login_params
    params.permit(:nickname, :password)
  end

end
