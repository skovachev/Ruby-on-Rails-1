class HomeController < ApplicationController
  def index
    collector = TweetCollector.new
    @tweets = collector.latest_positive_tweets_for 'gruber', count: 10, embedded: true
  end
end
