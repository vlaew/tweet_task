module Tweets
  module Creator
    class CreationResult
      attr_reader :tweet, :success

      def initialize(tweet)
        @tweet = tweet
        @success = @tweet.persisted?
      end
    end

    def self.create(user:, text:)
      tweet = Tweet.new(user: user, text: text)
      tweet.save
      CreationResult.new(tweet)
    end
  end
end
