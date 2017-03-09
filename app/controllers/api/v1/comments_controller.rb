class Api::V1::CommentsController < ApplicationController

  before_action :authenticate_user

  def index
    optional! :page, default: 1
    optional! :per, default: 20, values: 10..150
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @comments = Comment.with_search(params).with_filters(params).with_sort(params)
    @comments = @comments.includes(:user, :parent_comment).page(params[:page]).per(params[:per])
    render json: @comments, root: 'items', meta: meta_with_page(@comments)
  end

  def show

  end

  def create
    @comment = Comment.new
    authorize @comment
    @comment.assign_attributes(comment_params)
    if @comment.save
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def like
    @comment = Comment.find(params[:id])
    @comment.like_by!(current_user)
  end

  private

  def comment_params
    params.permit(
      :user_id, :description, :commentable_id, :commentable_type, :parent_id
    )
  end

end
