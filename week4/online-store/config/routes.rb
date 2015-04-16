Rails.application.routes.draw do

  # resource :brands
  get       'brands/count',                 to: 'brands#count'
  get       'brands/:index',                to: 'brands#get'
  get       'brands/range/:index/:count',   to: 'brands#range_offset_count'
  get       'brands/range/:index',          to: 'brands#range_offset'
  get       'brands',                       to: 'brands#index'
  post      'brands/new',                   to: 'brands#create'
  put       'brands/:index',                to: 'brands#update'
  delete    'brands/:index',                to: 'brands#destroy'

  # resource :categories
  get       'categories/count',                 to: 'categories#count'
  get       'categories/:index',                to: 'categories#get'
  get       'categories/range/:index/:count',   to: 'categories#range_offset_count'
  get       'categories/range/:index',          to: 'categories#range_offset'
  get       'categories',                       to: 'categories#index'
  post      'categories/new',                   to: 'categories#create'
  put       'categories/:index',                to: 'categories#update'
  delete    'categories/:index',                to: 'categories#destroy'

  # resource :products
  get       'products/count',                 to: 'products#count'
  get       'products/:index',                to: 'products#get'
  get       'products/range/:index/:count',   to: 'products#range_offset_count'
  get       'products/range/:index',          to: 'products#range_offset'
  get       'products',                       to: 'products#index'
  post      'products/new',                   to: 'products#create'
  put       'products/:index',                to: 'products#update'
  delete    'products/:index',                to: 'products#destroy'

end
