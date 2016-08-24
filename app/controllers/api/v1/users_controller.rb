class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  def index
    render :json => User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(update_params)
    render :json => @user
  end

  private
  def update_params
    params.permit(:name)
  end
end
