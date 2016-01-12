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

  context 'when new user has name which belongs to an existing user' do
    let(:name) { 'John Smith' }

    before do
      create(:user, name: name)
      @user = build(:user, name: name)
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
