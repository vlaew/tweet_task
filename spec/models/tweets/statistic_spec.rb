require 'rails_helper'

describe Tweets::Statistic, type: :model do
  let(:today) { Time.zone.today }
  let(:today_range) { Range.new(today, today) }
  let(:week_range) { Range.new(1.week.ago(today), today) }

  describe '#top_users' do
    context 'for today' do
      before do
        @expected_users = [
          create(:user_with_tweets, tweets_count: 3, date_range: today_range),
          create(:user_with_tweets, tweets_count: 7, date_range: today_range),
          create(:user_with_tweets, tweets_count: 9, date_range: today_range)
        ]
        create(:user_with_tweets, tweets_count: 19, date_range: Range.new(1.month.ago(today), 2.days.ago(today)))
        create(:user_with_tweets, tweets_count: 9, date_range: Range.new(1.month.ago(today), 2.days.ago(today)))
        create(:user_with_tweets, tweets_count: 2, date_range: Range.new(1.month.ago(today), 2.days.ago(today)))
      end

      it 'should return 3 top users' do
        expect(Tweets::Statistic.top_users(period: :today, top: 3).size).to eq(3)
      end

      it 'should return expected users' do
        users_ids = Tweets::Statistic.top_users(period: :today, top: 3).pluck(:id).sort
        expected_users_ids = @expected_users.map(&:id).sort
        expect(users_ids).to eq(expected_users_ids)
      end
    end

    context 'for week' do
      before do
        @expected_users = [
          create(:user_with_tweets, tweets_count: 3, date_range: week_range),
          create(:user_with_tweets, tweets_count: 7, date_range: week_range),
          create(:user_with_tweets, tweets_count: 9, date_range: week_range)
        ]
        create(:user_with_tweets, tweets_count: 19, date_range: Range.new(1.month.ago(today), 2.weeks.ago(today)))
        create(:user_with_tweets, tweets_count: 9, date_range: Range.new(1.month.ago(today), 2.weeks.ago(today)))
        create(:user_with_tweets, tweets_count: 2, date_range: Range.new(1.month.ago(today), 2.weeks.ago(today)))
      end

      it 'should return 3 top users' do
        expect(Tweets::Statistic.top_users(period: :week, top: 3).size).to eq(3)
      end

      it 'should return expected users' do
        users_ids = Tweets::Statistic.top_users(period: :week, top: 3).pluck(:id).sort
        expected_users_ids = @expected_users.map(&:id).sort
        expect(users_ids).to eq(expected_users_ids)
      end
    end

    context 'for all time' do
      before do
        @expected_users = [
          create(:user_with_tweets, tweets_count: 9, date_range: week_range),
          create(:user_with_tweets, tweets_count: 19, date_range: Range.new(2.months.ago(today), 2.weeks.ago(today))),
          create(:user_with_tweets, tweets_count: 9, date_range: Range.new(3.months.ago(today), 1.weeks.ago(today)))
        ]
        create(:user_with_tweets, tweets_count: 3, date_range: week_range)
        create(:user_with_tweets, tweets_count: 7, date_range: week_range)
        create(:user_with_tweets, tweets_count: 2, date_range: Range.new(1.month.ago(today), 2.weeks.ago(today)))
      end

      it 'should return 3 top users' do
        expect(Tweets::Statistic.top_users(period: :all_time, top: 3).size).to eq(3)
      end

      it 'should return expected users' do
        users_ids = Tweets::Statistic.top_users(period: :all_time, top: 3).pluck(:id).sort
        expected_users_ids = @expected_users.map(&:id).sort
        expect(users_ids).to eq(expected_users_ids)
      end
    end
  end

  describe '#top_tweets' do
    before do
      @creators = create_list(:user, 5)
    end

    context 'for today' do
      before do
        @expected_tweets = [
          create(:tweet_with_votes, user: @creators[0], created_at: Time.zone.now, rating: 3),
          create(:tweet_with_votes, user: @creators[1], created_at: Time.zone.now, rating: 5),
          create(:tweet_with_votes, user: @creators[2], created_at: Time.zone.now, rating: 7),
        ]
        @expected_users = @creators.take(3)
        create(:tweet_with_votes, user: @creators[3], created_at: Time.zone.now, rating: 1)
        create(:tweet_with_votes, user: @creators[4], created_at: Time.zone.now, rating: 0)
        create(:tweet_with_votes, user: @creators[3], created_at: Range.new(1.month.ago(today), 2.days.ago(today)).to_a.sample, rating: 9)
        create(:tweet_with_votes, user: @creators[1], created_at: Range.new(1.month.ago(today), 2.days.ago(today)).to_a.sample, rating: 7)
        create(:tweet_with_votes, user: @creators[4], created_at: Range.new(1.month.ago(today), 2.days.ago(today)).to_a.sample, rating: 8)
      end

      it 'should return 3 top tweets' do
        expect(Tweets::Statistic.top_tweets(period: :today, top: 3).size).to eq(3)
      end

      it 'should return expected tweets' do
        ids = Tweets::Statistic.top_tweets(period: :today, top: 3).pluck(:id).sort
        expected_ids = @expected_tweets.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end

      it 'should return expected users' do
        ids = Tweets::Statistic.top_tweets(period: :today, top: 3).map(&:user).map(&:id).sort
        expected_ids = @expected_users.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end
    end

    context 'for week' do
      before do
        @expected_tweets = [
          create(:tweet_with_votes, user: @creators[0], created_at: week_range.to_a.sample, rating: 3),
          create(:tweet_with_votes, user: @creators[1], created_at: week_range.to_a.sample, rating: 5),
          create(:tweet_with_votes, user: @creators[2], created_at: week_range.to_a.sample, rating: 7),
        ]
        @expected_users = @creators.take(3)
        create(:tweet_with_votes, user: @creators[3], created_at: Time.zone.now, rating: 1)
        create(:tweet_with_votes, user: @creators[4], created_at: Time.zone.now, rating: 0)
        create(:tweet_with_votes, user: @creators[3], created_at: Range.new(1.month.ago(today), 2.weeks.ago(today)).to_a.sample, rating: 9)
        create(:tweet_with_votes, user: @creators[1], created_at: Range.new(1.month.ago(today), 2.weeks.ago(today)).to_a.sample, rating: 7)
        create(:tweet_with_votes, user: @creators[4], created_at: Range.new(1.month.ago(today), 2.weeks.ago(today)).to_a.sample, rating: 8)
      end

      it 'should return 3 top tweets' do
        expect(Tweets::Statistic.top_tweets(period: :week, top: 3).size).to eq(3)
      end

      it 'should return expected tweets' do
        ids = Tweets::Statistic.top_tweets(period: :week, top: 3).pluck(:id).sort
        expected_ids = @expected_tweets.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end

      it 'should return expected users' do
        ids = Tweets::Statistic.top_tweets(period: :week, top: 3).map(&:user).map(&:id).sort
        expected_ids = @expected_users.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end
    end

    context 'for all time' do
      before do
        @expected_tweets = [
          create(:tweet_with_votes, user: @creators[3], created_at: Range.new(1.month.ago(today), 2.weeks.ago(today)).to_a.sample, rating: 9),
          create(:tweet_with_votes, user: @creators[1], created_at: Range.new(1.month.ago(today), 2.weeks.ago(today)).to_a.sample, rating: 7),
          create(:tweet_with_votes, user: @creators[4], created_at: Range.new(1.month.ago(today), 2.weeks.ago(today)).to_a.sample, rating: 8)
        ]
        @expected_users = [ @creators[1], @creators[3], @creators[4] ]
        create(:tweet_with_votes, user: @creators[3], created_at: Time.zone.now, rating: 1)
        create(:tweet_with_votes, user: @creators[4], created_at: Time.zone.now, rating: 0)
        create(:tweet_with_votes, user: @creators[0], created_at: week_range.to_a.sample, rating: 3)
        create(:tweet_with_votes, user: @creators[1], created_at: week_range.to_a.sample, rating: 5)
        create(:tweet_with_votes, user: @creators[2], created_at: week_range.to_a.sample, rating: 7)
      end

      it 'should return 3 top tweets' do
        expect(Tweets::Statistic.top_tweets(period: :all_time, top: 3).size).to eq(3)
      end

      it 'should return expected tweets' do
        ids = Tweets::Statistic.top_tweets(period: :all_time, top: 3).pluck(:id).sort
        expected_ids = @expected_tweets.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end

      it 'should return expected users' do
        ids = Tweets::Statistic.top_tweets(period: :all_time, top: 3).map(&:user).map(&:id).sort
        expected_ids = @expected_users.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end
    end
  end

  describe '#top_rating_users' do
    before do
      @creators = create_list(:user, 5)
    end

    context 'for today' do
      before do
        [3, 3, 2].each { |rating| create(:tweet_with_votes, user: @creators[0], created_at: today, rating: rating) }
        [5, 1, 3].each { |rating| create(:tweet_with_votes, user: @creators[1], created_at: today, rating: rating) }
        [7, 6].each { |rating| create(:tweet_with_votes, user: @creators[2], created_at: today, rating: rating) }

        @expected_users = @creators.take(3)
        [1, 1, 2, 2, 2, 3].each { |rating| create(:tweet_with_votes, user: @creators[3], created_at: today, rating: rating) }
        [2, 2, 2, 2, 2, 3].each { |rating| create(:tweet_with_votes, user: @creators[4], created_at: today, rating: rating) }
      end

      it 'should return 3 top users' do
        expect(Tweets::Statistic.top_rating_users(period: :today, top: 3).size).to eq(3)
      end

      it 'should return expected users' do
        ids = Tweets::Statistic.top_rating_users(period: :today, top: 3).pluck(:id).sort
        expected_ids = @expected_users.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end
    end

    context 'for week' do
      before do
        [3, 3, 2].each { |rating| create(:tweet_with_votes, user: @creators[0], created_at: week_range.to_a.sample, rating: rating) }
        [5, 1, 3].each { |rating| create(:tweet_with_votes, user: @creators[1], created_at: week_range.to_a.sample, rating: rating) }
        [7, 6].each { |rating| create(:tweet_with_votes, user: @creators[2], created_at: week_range.to_a.sample, rating: rating) }

        @expected_users = @creators.take(3)
        [1, 1, 2, 2, 2, 3].each { |rating| create(:tweet_with_votes, user: @creators[3], created_at: week_range.to_a.sample, rating: rating) }
        [6, 7, 8, 8, 9].each { |rating| create(:tweet_with_votes, user: @creators[4], created_at: today - 2.weeks, rating: rating) }
      end

      it 'should return 3 top users' do
        expect(Tweets::Statistic.top_rating_users(period: :week, top: 3).size).to eq(3)
      end

      it 'should return expected users' do
        ids = Tweets::Statistic.top_rating_users(period: :week, top: 3).pluck(:id).sort
        expected_ids = @expected_users.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end
    end

    context 'for all time' do
      before do
        [3, 3, 2].each { |rating| create(:tweet_with_votes, user: @creators[0], created_at: week_range.to_a.sample, rating: rating) }
        [5, 2, 3].each { |rating| create(:tweet_with_votes, user: @creators[1], created_at: week_range.to_a.sample, rating: rating) }
        [7, 6].each { |rating| create(:tweet_with_votes, user: @creators[2], created_at: week_range.to_a.sample, rating: rating) }
        [1, 1, 2, 2, 2, 3].each { |rating| create(:tweet_with_votes, user: @creators[3], created_at: week_range.to_a.sample, rating: rating) }
        [6, 7, 8, 8, 9].each { |rating| create(:tweet_with_votes, user: @creators[4], created_at: today - 2.weeks, rating: rating) }

        @expected_users = [ @creators[2], @creators[1], @creators[4] ]
      end

      it 'should return 3 top users' do
        expect(Tweets::Statistic.top_rating_users(period: :all_time, top: 3).size).to eq(3)
      end

      it 'should return expected users' do
        ids = Tweets::Statistic.top_rating_users(period: :all_time, top: 3).pluck(:id).sort
        expected_ids = @expected_users.map(&:id).sort
        expect(ids).to eq(expected_ids)
      end
    end
  end
end
