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
    type_symbol = type.to_sym
    return [] unless [:product, :category, :brand].include? type_symbol

    clazz = type.capitalize.constantize
    
    clazz.all.select do |item|
      prop = item[where[:property]].downcase
      slug = where[:slug].downcase
      (item.attributes.has_key? where[:property]) && (prop.include? slug)
    end
  end

end
