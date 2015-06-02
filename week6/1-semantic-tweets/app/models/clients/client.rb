require 'net/http'

module Clients
  class Client

    def load_config(key)
      key = key.to_s
      @consumer_key = Rails.application.config.clients[key]['api_key']
      @consumer_secret = Rails.application.config.clients[key]['api_secret']
    end

  end
end
