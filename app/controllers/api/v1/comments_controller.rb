class Api::V1::CommentsController < ApplicationController

  before_action :authenticate_user

  def index
    @comments = Comment.page(params[:page]).per(params[:per])
    render json: @comments, root: 'items', meta: meta_with_page(@comments)
  end

  def show

  end

  def create

  end

  def destroy

  end

  def like

  end

  private
  def comment_params
    params.permit(
      :user_id, :description, :commentable_id, :commentable_type, :parent_id
    )
  end
end
