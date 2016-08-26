class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  def index
    render :json => make_response(User.all)
  end

  def create
    User.create!(create_params)
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(update_params)
      render :json => make_response(@user)
    else
      render :json => make_response(nil, 1)
    end
  end

  private
  def create_params
    params.permit(:name, :password)
  end

  def update_params
    params.permit(:name)
  end
end
