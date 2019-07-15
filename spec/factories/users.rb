FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "email@test.local" }
    nickname { 'nickname' }
    provider { 'github' }
    uid { '1234' }
  end
end
