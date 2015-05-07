class HomeController < ApplicationController
  def index

  end

  def positive_tweets
    gateway = TweetGateway.new
    account = params[:account]
    raise "Twitter handle required" if account.blank?

    count = params[:count] || 30
    embedded = (params[:embedded] || 'yes') == 'yes'
    @tweets = gateway.latest_positive_tweets_for account, count: count, embedded: embedded
  end

  def post_positive_tweet
    tweet = params[:tweet]

    if tweet.blank? || tweet.length > 140
        flash[:notice] = 'Tweet content must be filled out and shorter than 140 characters.'
    else
      gateway = TweetGateway.new
      success = gateway.post_positive_tweet tweet

      if success
        flash[:notice] = 'Your positive tweet has been posted!'
      else
        flash[:notice] = 'Why so negative? Try again.'
      end
    end

    redirect_to action: 'index'
  end
end
