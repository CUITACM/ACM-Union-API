class Api::V1::AchievementsController < ApplicationController

  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    optional! :page, default: 1
    optional! :per, default: 15, values: 1..100
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @achievements = Achievement.with_search(params).with_filters(params).with_sort(params)
    @achievements = @achievements.page(params[:page]).per(params[:per])
    render json: @achievements, root: 'items', meta: meta_with_page(@achievements)
  end

  def show
    @achievement = Achievement.find(params[:id])
    render json: @achievement
  end

  def create
    @achievement = Achievement.new
    @achievement.assign_attributes(achievement_params)
    Rails.logger.info(achievement_params.inspect)
    if @achievement.save!
      render json: @achievement
    else
      render json: { error_code: 1 }
    end
  end

  def update
    @achievement = Achievement.find(params[:id])
    # authorize @user, :update_or_destroy?
    if @achievement.update!(achievement_params)
      render json: @achievement
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    # authorize @achievement, :update_or_destroy?
    if @achievement.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  private

  def achievement_params
    params.permit(:name, :description, :score, :achievement_type).tap do |white_listed|
      white_listed[:conditions] = params[:conditions].permit!
    end
  end
end
