Rails.application.routes.draw do

  get 'brands/count', to: 'brands#count'
  get 'brands/:index', to: 'brands#get'
  get 'brands/range/:index/:count', to: 'brands#range_offset_count'
  get 'brands/range/:index', to: 'brands#range_offset'
  get 'brands', to: 'brands#index'
  post 'brands/new', to: 'brands#create'
  put 'brands/:index', to: 'brands#update'
  delete 'brands/:index', to: 'brands#destroy'

end
