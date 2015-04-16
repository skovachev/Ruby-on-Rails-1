class SearchController < ApplicationController

  def search
    where = { slug: params[:slug], property: 'name' }
    render json: search_data(params[:type], where)
  end

  def search_property
    where = params.slice(:property, :slug)
    render json: search_data(params[:type], where)
  end

  private

  def search_data(type, where)
    type = type.to_sym
    return [] unless [:product, :category, :brand].include? type

    data = case type
    when :product
      Product.all
    when :category
      Category.all
    when :brand
      Brand.all
    else
      []
    end

    data.select do |item|
      prop = item[where[:property]].downcase
      slug = where[:slug].downcase
      (item.attributes.has_key? where[:property]) && (prop.include? slug)
    end
  end

end
