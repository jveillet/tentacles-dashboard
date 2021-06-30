# frozen_string_literal: true

OmniAuth.config.test_mode = true

omniauth_hash = {
  provider: 'github',
  uid: '123545',
  info: {
    name: 'mockuser',
    email: 'mock@mockuser.local',
    nickname: 'mocknickname',
    image: ''
  },
  credentials: {
    token: '1234567890'
  }
}

OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(omniauth_hash)
Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
