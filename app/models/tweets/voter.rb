module Tweets
  module Voter
    class VoteResult
      attr_reader :success

      def initialize(vote)
        @vote = vote
        @success = @vote.persisted?
      end
    end

    def self.vote(user:, tweet:)
      vote = Vote.new(user: user, tweet: tweet)
      vote.save
      VoteResult.new(vote)
    end
  end
end
