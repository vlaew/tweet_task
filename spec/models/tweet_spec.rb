require 'rails_helper'

describe Tweet, type: :model do
  let(:tweet_text) { 'Tweet content' }
  let(:too_long_text) { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sit amet convallis enim, sit amet auctor metus. Maecenas efficitur ipsum diam. Nunc condimentum, ante id.' }

  before do
    @user = create(:user)
  end

  context 'when tweet has valid fields' do
    before do
      @tweet = build(:tweet, user: @user, text: tweet_text)
      @tweet.valid?
    end

    it 'should be valid' do
      expect(@tweet.valid?).to eq(true)
    end

    it 'should not contain any errors' do
      expect(@tweet.errors.size).to eq(0)
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
      expect(@tweet.errors[:user].size).to eq(1)
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
      expect(@tweet.errors[:text].size).to eq(1)
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
      expect(@tweet.errors[:text].size).to eq(1)
    end
  end
end
