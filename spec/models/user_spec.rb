require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) { @user = FactoryBot.create(:user) }

  subject { @user }

  context 'Create a user' do

    it 'Has a name' do
      should respond_to(:name)
    end

    it 'Has an email' do
      should respond_to(:email)
    end

    it 'Has a nickname' do
      should respond_to(:nickname)
    end

    it 'Has a provider' do
      should respond_to(:provider)
    end

    it 'Has a uid' do
      should respond_to(:uid)
    end

    it 'Returns a valdi name' do
      expect(@user.name).to eq('Test User')
    end

    it 'Returns a valid email' do
      expect(@user.email).to eq('email@test.local')
    end

    it 'Returns a valid nickname' do
      expect(@user.nickname).to eq('nickname')
    end

    it 'Returns a valid uid' do
      expect(@user.uid).to eq('1234')
    end

    it 'Returns a valid provider' do
      expect(@user.provider).to eq('github')
    end
  end
end
