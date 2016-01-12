require 'rails_helper'

describe Vote, type: :model do
  before do
    @user = create(:user)
    @tweet = create(:tweet, user: @user)
  end

  describe 'newly created vote state' do
    subject { create(:vote, user: @user, tweet: @tweet) }

    its(:created_at) { is_expected.to be_a(Time) }
  end

  describe 'validation' do
    context 'when has user & tweet associated' do
      before do
        @vote = build(:vote, user: @user, tweet: @tweet)
        @vote.valid?
      end

      it 'should be valid' do
        expect(@vote.valid?).to eq(true)
      end

      it 'should not contain any errors' do
        expect(@vote.errors.any?).to eq(false)
      end
    end

    context 'when has no user' do
      before do
        @vote = build(:vote, user: nil, tweet: @tweet)
        @vote.valid?
      end

      it 'should be invalid' do
        expect(@vote.valid?).to eq(false)
      end

      it 'should contain error for user' do
        expect(@vote.errors[:user].any?).to eq(true)
      end
    end

    context 'when has no tweet' do
      before do
        @vote = build(:vote, user: @user, tweet: nil)
        @vote.valid?
      end

      it 'should be invalid' do
        expect(@vote.valid?).to eq(false)
      end

      it 'should contain error for tweet' do
        expect(@vote.errors[:tweet].any?).to eq(true)
      end
    end

    context 'when vote with such user and tweet exists' do
      before do
        create(:vote, user: @user, tweet: @tweet)
        @vote = build(:vote, user: @user, tweet: @tweet)
        @vote.valid?
      end

      it 'should be invalid' do
        expect(@vote.valid?).to eq(false)
      end

      it 'should contain error for tweet' do
        expect(@vote.errors[:tweet].any?).to eq(true)
      end
    end
  end
end
