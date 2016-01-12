require 'rails_helper'

describe Tweets::Creator, type: :model do
  let(:tweet_text) { 'Tweet content' }

  before do
    @user = create(:user)
  end

  describe '#create' do
    context 'when called with valid params' do
      it 'should increase count of existing tweets by 1' do
        expect {
          Tweets::Creator.create(user: @user, text: tweet_text)
        }.to change{ Tweet.count }.by(1)
      end

      describe 'returned result object' do
        subject(:result) { Tweets::Creator.create(user: @user, text: tweet_text) }

        it 'should be successful' do
          expect(result.success).to eq(true)
        end

        it 'should has a tweet' do
          expect(result.tweet).to be_a(Tweet)
        end

        it 'should has newly created tweet' do
          expect(result.tweet.persisted?).to eq(true)
        end
      end
    end

    context 'when called with invalid user' do
      it 'should not change count of existing tweets' do
        expect {
          Tweets::Creator.create(user: nil, text: tweet_text)
        }.not_to change{ Tweet.count }
      end

      describe 'returned result object' do
        subject(:result) { Tweets::Creator.create(user: nil, text: tweet_text) }

        it 'should not be successful' do
          expect(result.success).to eq(false)
        end

        it 'should has a tweet' do
          expect(result.tweet).to be_a(Tweet)
        end

        it 'should has newly created tweet' do
          expect(result.tweet.persisted?).to eq(false)
        end
      end
    end

    context 'when called with invalid text' do
      it 'should not change count of existing tweets' do
        expect {
          Tweets::Creator.create(user: @user, text: '')
        }.not_to change{ Tweet.count }
      end

      describe 'returned result object' do
        subject(:result) { Tweets::Creator.create(user: @user, text: '') }

        it 'should not be successful' do
          expect(result.success).to eq(false)
        end

        it 'should has a tweet' do
          expect(result.tweet).to be_a(Tweet)
        end

        it 'should has newly created tweet' do
          expect(result.tweet.persisted?).to eq(false)
        end
      end
    end
  end
end
