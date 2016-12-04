class Api::V1::SpidersController < ApplicationController

  before_action :authenticate_user, except: [:accounts]

  def accounts
    @accounts = Account.page(params[:page] || 1).per(params[:per])
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

  def delete_account
    @account = Account.find(params[:id])
    if @account.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def submits
    @submits = Submit.page(params[:page] || 1).per(params[:per])
    render json: @submits, root: 'items', meta: meta_with_page(@submits)
  end

  private

  def account_params
    params.permit(:nickname, :password, :oj_name, :user_id)
  end
end
