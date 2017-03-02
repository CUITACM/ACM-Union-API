class Api::V1::MiscController < ApplicationController

  before_action :authenticate_user, only: []

  def dashboard
    render json: {
      error_code: 0,
      data: {
        user_count: User.normal.count,
        newcomer_count: User.newcomer.count,
        news_count: Article.news.count,
        solution_count: Article.solution.count,
        account_count: Account.count,
        submit_count: Submit.count,
        resource_count: Resource.count,
      }
    }
  end
end
