class Api::V1::ArticlesController < ApplicationController

  before_action :authenticate_user, except: [:index]

  def index
    optional! :page, default: 1
    optional! :per, default: 10, values: 1..50
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @articles = Article.with_search(params).with_filters(params).with_sort(params)
    @articles = @articles.includes(:user, :tags).page(params[:page]).per(params[:per])
    render json: @articles, root: 'items', meta: meta_with_page(@articles)
  end

  def solutions
    optional! :page, default: 1
    optional! :per, default: 10, values: 1..50

    @solutions = Article.solution.order(created_at: :desc)
      .with_sort(params).with_search(params).with_filters(params)
    @solutions = @solutions.includes(:user, :tags).page(params[:page]).per(params[:per])
    render json: @solutions, root: 'items', meta: meta_with_page(@solutions)
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
      render json: @article
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

  def comments
    optional! :page, default: 1
    optional! :per, default: 10, values: 1..50
    optional! :sort_field, default: :created_at
    optional! :sort_order, default: :descend, values: %w(ascend descend)

    article_id = params[:id]
    @comments = Comment.by_article(article_id).with_sort(params)
    @comments = @comments.includes(:user, :parent_comment)
      .page(params[:page]).per(params[:per])
    render json: @comments, root: 'items', meta: meta_with_page(@comments)
  end

  def create_comment
    article_id = params[:id]
    @comment = Comment.new
    @comment.assign_attributes(comment_params.merge({
      user_id: current_user.id,
      commentable_id: article_id,
      commentable_type: 'Article'
    }))
    if @comment.save
      render json: { error_code: 0, comment: @comment }
    else
      render json: { error_code: 1 }
    end
  end

  private

  def article_params
    params.permit(:title, :content, :status, :article_type)
  end

  def comment_params
    params.permit(:description, :parent_id)
  end

end
