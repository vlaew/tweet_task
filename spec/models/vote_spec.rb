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
  end
end
