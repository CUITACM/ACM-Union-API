class Api::V1::HonorsController < ApplicationController

  before_action :authenticate_user, only: []

  def index
    optional! :page, default: 1
    optional! :per, default: 10, values: 1..20
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @honors = Honor.with_search(params).with_filters(params).with_sort(params)
    @honors = @honors.page(params[:page]).per(params[:per])
    render json: @honors, root: 'items', meta: meta_with_page(@honors)
  end

end
