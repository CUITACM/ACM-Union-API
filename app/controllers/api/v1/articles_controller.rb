class Api::V1::ArticlesController < ApplicationController

  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    optional! :page, default: 1
    optional! :per, default: 10, values: 1..50
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @articles = Article.with_search(params).with_filters(params).with_sort(params)
    @articles = @articles.includes(:user, :tags).page(params[:page]).per(params[:per])
    render json: @articles, root: 'items', meta: meta_with_page(@articles)
  end

  def show
    @article = Article.find(params[:id])
    render json: @article
  end

  def create
    @article = Article.new
    authorize @article
    @article.assign_attributes(article_params)
    @article.user_id = current_user.id
    if @article.save
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def update
    @article = Article.find(params[:id])
    authorize @article, :update_or_destroy?
    if @article.update_with_tags(params[:tags], article_params)
      render json: @article
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article, :update_or_destroy?
    if @article.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def like
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.permit(:title, :content, :status, :article_type)
  end

end
