require 'rails_helper'

describe Tweet, type: :model do
  let(:tweet_text) { 'Tweet content' }
  let(:too_long_text) { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sit amet convallis enim, sit amet auctor metus. Maecenas efficitur ipsum diam. Nunc condimentum, ante id.' }

  before do
    @user = create(:user)
  end

  describe 'newly created tweet state' do
    subject { create(:tweet, user: @user) }

    its(:created_at) { is_expected.to be_a(Time) }
  end

  describe 'validation' do
    context 'when tweet has valid fields' do
      before do
        @tweet = build(:tweet, user: @user, text: tweet_text)
        @tweet.valid?
      end

      it 'should be valid' do
        expect(@tweet.valid?).to eq(true)
      end

      it 'should not contain any errors' do
        expect(@tweet.errors.any?).to eq(false)
      end
    end

    context 'when tweet has no user' do
      before do
        @tweet = build(:tweet, user: nil, text: tweet_text)
        @tweet.valid?
      end

      it 'should be invalid' do
        expect(@tweet.valid?).to eq(false)
      end

      it 'should contain error for user field' do
        expect(@tweet.errors[:user].any?).to eq(true)
      end
    end

    context 'when tweet has no text' do
      before do
        @tweet = build(:tweet, user: @user, text: '')
        @tweet.valid?
      end

      it 'should be invalid' do
        expect(@tweet.valid?).to eq(false)
      end

      it 'should contain error for text field' do
        expect(@tweet.errors[:text].any?).to eq(true)
      end
    end

    context 'when tweet has too long text' do
      before do
        @tweet = build(:tweet, user: @user, text: too_long_text)
        @tweet.valid?
      end

      it 'should be invalid' do
        expect(@tweet.valid?).to eq(false)
      end

      it 'should contain error for text field' do
        expect(@tweet.errors[:text].any?).to eq(true)
      end
    end
  end
end
