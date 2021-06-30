# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  describe '#create' do
    it 'successfully create a user' do
      expect do
        post :create, params: { provider: :github }
      end.to change(User, :count).by(1)
    end

    it 'has a valid user' do
      expect(session[:user_id]).to be_nil
    end

    it 'successfully create a session' do
      post :create, params: { provider: :github }
      expect(session[:user_id]).not_to be_nil
    end

    it 'redirects the user to the root url' do
      post :create, params: { provider: :github }
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#destroy' do
    before do
      post :create, params: { provider: :github }
    end

    it 'has a valid session' do
      expect(session[:user_id]).not_to be_nil
    end

    it 'clears the session' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects the user to the sign in page' do
      delete :destroy
      expect(response).to redirect_to(signin_path)
    end
  end
end
