Rails.application.routes.draw do

  concern :ranged do
      get 'range/:index/:count',   to: :range_offset_count
      get 'range/:index',          to: :range_offset
  end

  concern :countable do
      get 'count',   to: :count
  end

  # resource :brands
  resources :brands, concerns: [:ranged, :countable], except: [:new]
  post      'brands/new',                   to: 'brands#create'

  # resource :categories
  resources :categories, concerns: [:ranged, :countable], except: [:new]
  post      'categories/new',                   to: 'categories#create'

  # resource :products
  resources :products, concerns: [:ranged, :countable], except: [:new]
  post      'products/new',                   to: 'products#create'

  get 'search/:type/:slug',           to: 'search#search'
  get 'search/:type/:property/:slug', to: 'search#search_property'

end
