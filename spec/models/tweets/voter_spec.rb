require 'rails_helper'

describe Tweets::Voter, type: :model do
  before do
    @user = create(:user)
    @tweet = create(:tweet, user: @user)
  end

  subject(:voter) { Tweets::Voter }

  describe '#vote' do
    context 'when called with valid params' do
      it 'should increase rating of the tweet by 1' do
        expect {
          voter.vote(user: @user, tweet: @tweet)
        }.to change{ @tweet.rating }.by(1)
      end

      describe 'returned result object' do
        subject(:result) { voter.vote(user: @user, tweet: @tweet) }

        it 'should be successful' do
          expect(result.success).to eq(true)
        end
      end
    end

    context 'when called with invalid user' do
      it 'should not affect rating of the tweet' do
        expect {
          voter.vote(user: nil, tweet: @tweet)
        }.not_to change{ @tweet.rating }
      end

      describe 'returned result object' do
        subject(:result) { voter.vote(user: nil, tweet: @tweet) }

        it 'should not be successful' do
          expect(result.success).to eq(false)
        end
      end
    end

    context 'when called with invalid tweet' do
      describe 'returned result object' do
        subject(:result) { voter.vote(user: @user, tweet: nil) }

        it 'should not be successful' do
          expect(result.success).to eq(false)
        end
      end
    end

    context 'when already been called with the same user & tweet' do
      describe 'returned result object' do
        before do
          voter.vote(user: @user, tweet: @tweet)
        end

        it 'should not affect rating of the tweet' do
          expect {
            voter.vote(user: @user, tweet: @tweet)
          }.not_to change{ @tweet.rating }
        end

        subject(:result) { voter.vote(user: @user, tweet: @tweet) }

        it 'should not be successful' do
          expect(result.success).to eq(false)
        end
      end
    end
  end
end
