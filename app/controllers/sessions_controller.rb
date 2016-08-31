class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by(nickname: login_params[:nickname])
    if @user && @user.authenticate(login_params[:password])
      self.current_user = @user
      render json: current_user, serializer: SessionSerializer
    else
      unauthenticated!
    end
  end

  def register
    
  end

  def login_params
    params.permit(:nickname, :password)
  end

  def register_params
    params.permit(:email, :password)
  end

  private :login_params, :register_params
end
