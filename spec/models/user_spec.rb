# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context 'when I create a user' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'has a name' do
      expect(user.name).not_to be_empty
    end

    it 'has an email' do
      expect(user.email).not_to be_empty
    end

    it 'has a nickname' do
      expect(user.nickname).not_to be_empty
    end

    it 'has a provider' do
      expect(user.provider).not_to be_empty
    end

    it 'has a uid' do
      expect(user.uid).not_to be_empty
    end

    it 'returns a valid name' do
      expect(user.name).to eq('Test User')
    end

    it 'returns a valid email' do
      expect(user.email).to eq('email@test.local')
    end

    it 'returns a valid nickname' do
      expect(user.nickname).to eq('nickname')
    end

    it 'returns a valid uid' do
      expect(user.uid).to eq('1234')
    end

    it 'returns a valid provider' do
      expect(user.provider).to eq('github')
    end
  end
end
