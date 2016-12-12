class Api::V1::ArticlesController < ApplicationController

  before_action :authenticate_user

  def index
    @articles = Article.with_search(params).with_filters(params).with_sort(params)
    @articles = @articles.page(params[:page] || 1).per(params[:per])
                    .includes(:user, :tags)
    render json: @articles, root: 'items', meta: meta_with_page(@articles)
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
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

  private

  def article_params
    params.permit(:title, :content, :status, :article_type)
  end

end
