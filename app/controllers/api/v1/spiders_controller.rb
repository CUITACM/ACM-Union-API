class Api::V1::SpidersController < ApplicationController

  before_action :authenticate_user, except: [:accounts, :submits]

  def accounts
    optional! :page, default: 1
    optional! :per, default: 15, values: 1..150
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @accounts = Account.with_search(params).with_filters(params).with_sort(params)
    @accounts = @accounts.includes(:user).page(params[:page]).per(params[:per])
    render json: @accounts, root: 'items', meta: meta_with_page(@accounts)
  end

  def create_account
    if Account.exists?(oj_name: account_params[:oj_name], user_id: current_user.id)
      render json: { error_code: 1, message: '账号已存在' } and return
    end
    @account = Account.new(account_params)
    if @account.save!
      render json: @account
    else
      render json: { error_code: 1 }
    end
  end

  def update_account
    @account = Account.find(params[:id])
    if @account.update(account_params)
      render json: @account
    else
      render json: { error_code: 1 }
    end
  end

  def delete_account
    @account = Account.find(params[:id])
    if @account.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def submits
    optional! :page, default: 1
    optional! :per, default: 20, values: 1..500
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @submits = Submit.with_search(params).with_filters(params).with_sort(params)
    @submits = @submits.page(params[:page]).per(params[:per])
    render json: @submits, root: 'items', meta: meta_with_page(@submits)
  end

  def workers
    @workers = SpiderService.get_open_spider_workers
    render json: @workers
  end

  def open_worker
    requires! :oj, values: Account::OJ_DICT.values

    oj_name = params[:oj]
    render json: SpiderService.open_spider_worker(oj_name)
  end

  def stop_worker
    requires! :oj, values: Account::OJ_DICT.values

    oj_name = params[:oj]
    render json: SpiderService.stop_spider_worker(oj_name)
  end

  def rank_list
    optional! :page, default: 1
    optional! :per, default: 15, values: 10..30

    @rank_list, @meta = SpiderService.get_rank_list(params[:page], params[:per])
    render json: {items: @rank_list, meta: @meta}
  end

  private

  def account_params
    params.permit(:nickname, :password, :oj_name, :user_id)
  end
end
