class SessionsController < ApplicationController

  def login
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      self.current_user = @user
      render :json => current_user
    else
      unauthenticated!
    end
  end

  def register
    
  end

  private
  def login_params
    params.permit(:email, :password)
  end
end
