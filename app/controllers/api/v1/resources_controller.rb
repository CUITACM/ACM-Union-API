class Api::V1::ResourcesController < ApplicationController

  before_action :authenticate_user, only: [:create, :destroy]

  def index
    optional! :page, default: 1
    optional! :per, default: 10, values: 1..50

    @resources = Resource.page(params[:page]).per(params[:per])
    render json: @resources, root: 'items', meta: meta_with_page(@resources)
  end

  def show
    @resource = Resource.find(params[:id])
    render json: @resource
  end

  def create
    if Resource.exists?(filename: params[:filename])
      render json: { error_code: 2 } and return
    end
    @resource = Resource.new
    @resource.assign_attributes(resource_params)
    @resource.owner_id = current_user.id
    if @resource.save
      render json: @resource, meta: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    if @resource.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  private

  def resource_params
    params.permit(:path, :filename, :usage)
  end

end
