# Brands controller
class BrandsController < ApplicationController
  def count 
    Brand.count
  end

  def index
    render json: Brand.all
  end

  def show
    render json: Brand.find(params[:id])
  end

  def range_offset_count
    render json: Brand.limit(params[:count]).offset(params[:index])
  end

  def range_offset
    render json: Brand.offset(params[:index])
  end

  def create
    render json: Brand.create(brand_params)
  end

  def update
    brand = Brand.find(params[:id])
    brand.update(brand_params)
    render json: brand
  end

  def destroy
    brand = Brand.find(params[:id])
    brand.destroy
    render json: true
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :short_description)
  end
end
