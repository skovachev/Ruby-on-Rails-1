Rails.application.routes.draw do
  root 'home#welcome'

  get 'sign_in', to: 'login#sign_in'
  get 'sign_up', to: 'login#sign_up'
  get 'logout', to: 'login#logout'

  post 'sign_in', to: 'login#sign_in_do'
  post 'sign_up', to: 'login#sign_up_do'
end
