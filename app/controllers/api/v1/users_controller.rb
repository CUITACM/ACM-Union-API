class Api::V1::UsersController < ApplicationController

  def index
    @users = User.ant_sort(params).with_search(params)
    @users = @users.page(params[:page] || 1).per(params[:per])
    render json: @users, meta: meta_with_page(@users)
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new
    @user.assign_attributes(create_params)
    if @user.save
      render json: @user
    else
      render json: { error_code: 1 }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
      render json: @user
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def create_params
    params.permit(:name, :password)
  end

  def update_params
    params.permit(:name)
  end

  private :create_params, :update_params
end
