module Clients
  class Twitter < Client
    def initialize
      load_config :twitter
    end

    def latest_tweets_for(user, count = 20)
      url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{user}&count=#{count}"
      response = request(url)

      JSON.parse(response.body).collect do |t|
        data = t.select { |key, value| [:text, :id].include? key.to_sym }
        data['html'] = data['text']
        Tweet.new(data)
      end
    end

    def get_embed_html(tweet)
      embed_url = 'https://api.twitter.com/1.1/statuses/oembed.json?hide_thread=true&id=' + tweet.id.to_s
      embed_data = JSON.parse(request(embed_url).body)
      embed_data['html']
    end

    def post_tweet(content)
      url = "https://api.twitter.com/1.1/statuses/update.json"
      data = { status: content }
      request(url, :post, data)
    end

    protected

    def request(url, method = :get, params = [])
      token = prepare_access_token(
        Rails.application.config.clients['twitter']['access_token'],
        Rails.application.config.clients['twitter']['access_token_secret']
      )

      token.request(method, url, params)
    end

    def prepare_access_token(oauth_token, oauth_token_secret)
      consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, { :site => "https://api.twitter.com", :scheme => :header })

      # now create the access token object from passed values
      token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
      OAuth::AccessToken.from_hash(consumer, token_hash )
    end

  end
end
