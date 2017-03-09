class Api::V1::HonorsController < ApplicationController

  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    optional! :page, default: 1
    optional! :per, default: 10, values: 1..20
    optional! :sort_field, default: :id
    optional! :sort_order, default: :ascend, values: %w(ascend descend)

    @honors = Honor.with_search(params).with_filters(params).with_sort(params)
    @honors = @honors.page(params[:page]).per(params[:per])
    render json: @honors, root: 'items', meta: meta_with_page(@honors)
  end

  def show
    @honor = Honor.find(params[:id])
    render json: @honor
  end

  def create
    @honor = Honor.new
    @honor.assign_attributes(honor_params)
    modify_images(@honor, params)
    if @honor.save
      render json: @honor
    else
      render json: { error_code: 1 }
    end
  end

  def update
    @honor = Honor.find(params[:id])
    @honor.assign_attributes(honor_params)
    modify_images(@honor, params)
    if @honor.save
      render json: @honor
    else
      render json: { error_code: 1 }
    end
  end

  def destroy
    @honor = Honor.find(params[:id])
    if @honor.destroy
      render json: { error_code: 0 }
    else
      render json: { error_code: 1 }
    end
  end

  private

  def modify_images(honor, params)
    images = honor.images || []
    puts images
    if params[:remove_images].present?
      remove_images = params[:remove_images].split(',')
      puts "remove_images => #{remove_images}"
      remove_images.map(&:to_i).each do |index|
        deleted_image = images.delete_at(index)
        deleted_image.try(:remove!)
        puts images
      end
    end
    images += params[:images] if params[:images].present?
    honor.images = images
    if honor.images.size == 0 && honor.read_attribute(:images).size == 1
      honor.write_attribute(:images, [])
    end
  end

  def honor_params
    params.permit(:contest_name, :contest_level, :description, :team_name, :remove_images, images: [])
      .except(:images, :remove_images)
  end

end
