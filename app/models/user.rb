class User < ApplicationRecord
  ##
  # Create a user from the Omniauth information
  #
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name']
        user.nickname = auth['info']['nickname']
        user.email = auth['info']['email']
        user.image = auth['info']['image']
      end
    end
  end
end
