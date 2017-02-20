class Api::V1::UsersController < ApplicationController

  before_action :authenticate_user

  def index
    optional! :page, default: 1
    optional! :per, default: 20, values: 1..50
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @users = User.with_search(params).with_filters(params).with_sort(params)
    @users = @users.includes(:user_info).page(params[:page]).per(params[:per])
    render json: @users, root: 'items', meta: meta_with_page(@users)
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new
    @user.assign_attributes(user_params)
    @user.update_user_info(params)
    if @user.save!
      render json: @user
    else
      render json: { error_code: 1 }
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user, :update_or_destroy?
    @user.update_user_info(params)
    if @user.update!(user_params)
      render json: @user
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user, :update_or_destroy?
    if @user.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  private

  def user_params
    params.permit(
      :display_name, :nickname, :gender, :avatar,
      :role, :status, :description
    )
  end

end
