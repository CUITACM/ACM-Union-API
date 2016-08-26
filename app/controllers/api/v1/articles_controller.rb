class Api::V1::ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
  end
end
