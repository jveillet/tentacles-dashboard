# frozen_string_literal: true

# config/initializers/omniauth.rb

OmniAuth.config.logger = Rails.logger
OmniAuth.config.allowed_request_methods = [:post]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           ENV['GITHUB_CLIENT_ID'],
           ENV['GITHUB_CLIENT_SECRET'],
           scope: 'user,repo,read:org,public_repo,read:discussion'
end

