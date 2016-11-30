class Api::V1::SpidersController < ApplicationController

  def accounts
    @accounts = Account.page(params[:page] || 1).per(params[:per])
    render json: @accounts, root: 'items', meta: meta_with_page(@accounts)
  end

  def create_account
    @account = Account.new
    @account.assign_attributes(account_params)
    if @account.save!
      render json: @account
    else
      render json: { error_code: 1 }
    end
  end

  private

  def account_params
    params.permit(:nickname, :password, :oj_name, :user_id)
  end
end
