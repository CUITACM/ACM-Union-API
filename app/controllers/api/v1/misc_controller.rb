class Api::V1::MiscController < ApplicationController

  before_action :authenticate_user, only: [:statistic]

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

  def statistic
    @solutions = Article.solution.where(user_id: current_user.id)
    @submits = Submit.where(user_id: current_user.id)
    render json: {
      error_code: 0,
      data: [
        {
          name: '发表解题报告',
          count: @solutions.count,
        },
        {
          name: '收获点赞',
          count: @solutions.sum(:like_times),
        },
        {
          name: '单篇解题报告最多点赞',
          count: @solutions.maximum(:like_times),
        },
        {
          name: '解题提交',
          count: @submits.count,
        },
        {
          name: '解题 Accept',
          count: Submit.user_accepted(current_user.id).count,
        }
      ]
    }
  end

end
