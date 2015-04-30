Rails.application.routes.draw do
  root 'lectures#index'

  resources :lectures do
    resources :tasks do
      resources :solutions
    end
  end
end
