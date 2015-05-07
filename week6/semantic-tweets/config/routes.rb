Rails.application.routes.draw do
  root 'home#index'
  get 'positive-tweets', to: 'home#positive_tweets'
  post 'post-positive-tweet', to: 'home#post_positive_tweet'
end
