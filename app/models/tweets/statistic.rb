module Tweets
  module Statistic
    PERIOD_RANGE = {
      today: -> { Range.new(Time.zone.today, Time.zone.today) },
      week: -> { Range.new(1.week.ago(Time.zone.today), Time.zone.today) },
      all_time: -> { nil },
      default: -> { nil }
    }

    def self.top_users(period:, top: 5)
      tweets_join = Tweet.in_period(period_to_range(period))
                         .with_count_by_user
      User.joins("LEFT JOIN (#{tweets_join.to_sql}) as user_tweets ON user_tweets.user_id = users.id ")
          .order('COALESCE(total_tweets, 0) DESC')
          .limit(top)
    end

    private

    def self.period_to_range(period)
      PERIOD_RANGE.fetch(period, PERIOD_RANGE.fetch(:default)).call
    end
  end
end
