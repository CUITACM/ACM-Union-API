class Api::V1::SpidersController < ApplicationController

  before_action :authenticate_user, except: [:accounts, :submits]

  def accounts
    @accounts = Account.with_search(params).with_filters(params).with_sort(params)
    @accounts = @accounts.includes(:user).page(params[:page] || 1).per(params[:per])
    render json: @accounts, root: 'items', meta: meta_with_page(@accounts)
  end

  def create_account
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
    @submits = Submit.with_search(params).with_filters(params).with_sort(params)
    @submits = @submits.page(params[:page] || 1).per(params[:per])
    render json: @submits, root: 'items', meta: meta_with_page(@submits)
  end

  def workers
    @workers = SpiderService.get_open_spiders
    render json: @workers
  end

  private

  def account_params
    params.permit(:nickname, :password, :oj_name, :user_id)
  end
end
