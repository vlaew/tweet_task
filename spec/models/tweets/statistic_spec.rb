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
end
