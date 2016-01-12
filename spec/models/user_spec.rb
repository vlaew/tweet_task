require 'rails_helper'

describe User, type: :model do
  context 'when user has valid name' do
    before do
      @user = build(:user, name: 'Jane Doe')
      @user.valid?
    end

    it 'should be valid' do
      expect(@user.valid?).to eq(true)
    end

    it 'should not contain error for name' do
      expect(@user.errors[:name].size).to eq(0)
    end
  end

  context 'when new user has no name' do
    before do
      @user = build(:user, name: nil)
      @user.valid?
    end

    it 'should be invalid' do
      expect(@user.valid?).to eq(false)
    end

    it 'should contain error for name' do
      expect(@user.errors[:name].size).to eq(1)
    end
  end
end
