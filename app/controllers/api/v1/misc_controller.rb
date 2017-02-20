class Api::V1::MiscController < ApplicationController

  before_action :authenticate_user

  def dashboard
    render json: {
      error_code: 0,
      data: {
        user_count: User.normal.count,
        new_comer_count: User.new_comer.count,
        news_count: Article.news.count,
        solution_count: Article.solution.count,
        account_count: Account.count,
        submit_count: Submit.count,
        resource_count: Resource.count,
      }
    }
  end
end
