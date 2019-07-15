OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  'provider': 'github',
  'uid': '123545',
  'info': {
    'name': 'mockuser',
    'email': 'mock@mockuser.local',
    'nickname': 'mocknickname',
    'image': ''
  }
})
