# Categories controller
class CategoriesController < ApplicationController
  def count
    Category.count
  end

  def index
    render json: Category.all
  end

  def show
    render json: Category.find(params[:id])
  end

  def range_offset_count
    render json: Category.limit(params[:count]).offset(params[:index])
  end

  def range_offset
    render json: Category.offset(params[:index])
  end

  def create
    render json: Category.create(category_params)
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)
    render json: category
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    render json: true
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
