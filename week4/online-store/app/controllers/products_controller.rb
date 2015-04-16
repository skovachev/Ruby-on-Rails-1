# Products controller
class ProductsController < ApplicationController
  def count 
    Product.count
  end

  def index
    render json: Product.all
  end

  def get
    render json: Product.find(params[:index])
  end

  def range_offset_count
    render json: Product.limit(params[:count]).offset(params[:index])
  end

  def range_offset
    render json: Product.offset(params[:index])
  end

  def create
    render json: Product.create(product_params)
  end

  def update
    product = Product.find(params[:index])
    product.update(product_params)
    render json: product
  end

  def destroy
    product = Product.find(params[:index])
    product.destroy
    render json: true
  end

  private

  def product_params
    params.require(:product).permit(:name, :stock, :price, :category_id, :brand_id)
  end
end
