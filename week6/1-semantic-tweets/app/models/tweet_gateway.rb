class TweetGateway
  def initialize
    @twitter_client = Clients::Twitter.new
    @semantria_client = Clients::SemantriaClient.new
  end

  def latest_positive_tweets_for(user, embedded: false, count: 20)
    tweets = @twitter_client.latest_tweets_for(user, count)
    tweets = @semantria_client.filter_positive_tweets(tweets)
    if embedded
      tweets.collect! do |tweet|
        tweet.html = @twitter_client.get_embed_html(tweet)
        tweet
      end
    end
    tweets
  end

  def post_positive_tweet(content)
    if @semantria_client.is_positive(content)
      @twitter_client.post_tweet content
      true
    else
      false
    end
  end
end
