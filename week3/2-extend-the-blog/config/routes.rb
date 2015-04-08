Rails.application.routes.draw do

  root 'home#index'

  get 'posts/new'
  post 'posts/create'
  get 'posts/:id' => 'posts#show'
  delete 'posts/:id' => 'posts#destroy'

  get 'photos' => 'photos#index'
  get 'photos/new'
  post 'photos/create'
  get 'photos/:id' => 'posts#show'

  get 'search/:tag' => 'search#tag'

  # custom error route
  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

  # catch all invalid routes to 404
  match '*a', :to => 'errors#error404', via: [ :get, :post, :patch, :delete ]

end
