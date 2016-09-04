class Api::V1::ArticlesController < ApplicationController

  def index
    @articles = Article.ant_sort(params).with_search(params)
    @articles = @articles.page(params[:page] || 1).per(params[:per])
                    .includes(:user)
    render json: @articles, meta: meta_with_page(@articles)
  end

  def show
    @article = Article.find(params[:id])
    render json: @article
  end

  def create
    @article = Article.new
    @article.assign_attributes(create_params)
    if @article.save
      render json: @article
    else
      render json: { error_code: 1 }
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(update_params)
      render json: @article
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def create_params
    params.permit(:title)
  end

  def update_params
    params.permit(:title)
  end

  private :create_params, :update_params
end
