require 'semantria'

class SessionCallbackHandler < Semantria::CallbackHandler
  def onRequest(sender, args)
    #print "Request: ", args, "\n"
  end

  def onResponse(sender, args)
    #print "Response: ", args, "\n"
  end

  def onError(sender, args)
    print 'Error: ', args, "\n"
  end

  def onDocsAutoResponse(sender, args)
    #print "DocsAutoResponse: ", args.length, args, "\n"
  end

  def onCollsAutoResponse(sender, args)
    #print "CollsAutoResponse: ", args.length, args, "\n"
  end
end

module Clients
  class SemantriaClient < Client

    def initialize
      load_config :semantria
    end

    def filter_positive_tweets(tweets)
      session = Semantria::Session.new(@consumer_key, @consumer_secret, 'SemanticTweets', true)
      callback = SessionCallbackHandler.new()
      session.setCallbackHandler(callback)

      tweets.each do |tweet|
        doc = tweet.as_json
        puts doc
        # Queues document for processing on Semantria service
        status = session.queueDocument(doc)
        # Check status from Semantria service
        if status == 202
          print 'Document ', doc['id'], ' queued successfully.', "\r\n"
        end
      end

      length = tweets.length
      results = {}

      while results.length < length
        # As Semantria isn't real-time solution you need to wait some time before getting of the processed results
        # In real application here can be implemented two separate jobs, one for queuing of source data another one for retrieving
        # Wait ten seconds while Semantria process queued document
        sleep(1)
        # Requests processed results from Semantria service
        status = session.getProcessedDocuments()
        # Check status from Semantria service
        status.is_a? Array and status.each do |object|
          results[object['id'].to_i] = object
        end
      end

      tweets.select do |tweet|
        tweet.analysis_data = results[tweet.id]
        tweet.analysis_data['sentiment_score'] > 0
      end
    end
  end
end
