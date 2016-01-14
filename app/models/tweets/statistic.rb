module Tweets
  module Statistic
    PERIOD_RANGE = {
      today: -> { today...(today + 1.day) },
      week: -> { 1.week.ago(today)...(today + 1.day) },
      all_time: -> { nil },
      default: -> { nil }
    }

    def self.top_users(period:, top: 5)
      tweets_join = Tweet.in_period(period_to_range(period)).with_count_by_user
      join_string = <<-SQL
        LEFT JOIN (#{tweets_join.to_sql}) as user_tweets
        ON user_tweets.user_id = users.id
      SQL
      User.joins(join_string)
        .order('COALESCE(total_tweets, 0) DESC')
        .limit(top)
    end

    def self.top_tweets(period:, top: 5)
      Tweet.in_period(period_to_range(period))
        .includes(:user)
        .order(votes_count: :desc)
        .limit(top)
    end

    def self.top_rating_users(period:, top: 5)
      tweets_join = Tweet.in_period(period_to_range(period))
                    .with_average_rating_by_user
      join_string = <<-SQL
        LEFT JOIN (#{tweets_join.to_sql}) as user_tweets
        ON user_tweets.user_id = users.id
      SQL
      User.joins(join_string)
        .select('*, user_tweets.average_rating')
        .order('COALESCE(average_rating, 0) DESC')
        .limit(top)
    end

    private

    def self.period_to_range(period)
      p = period.to_s.to_sym
      PERIOD_RANGE.fetch(p, PERIOD_RANGE.fetch(:default)).call
    end

    def self.today
      Time.zone.today.to_datetime
    end
  end
end
