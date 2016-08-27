class SessionsController < ApplicationController

  def login
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      self.current_user = @user
      render :json => current_user, :serializer => SessionSerializer
    else
      unauthenticated!
    end
  end

  def register
    
  end

  private :login_params, :register_params

  def login_params
    params.permit(:email, :password)
  end

  def register_params
    params.permit(:email, :password)
  end
end
