# frozen_string_literal: true

##
# Global Application Helper
#
module ApplicationHelper
  def pr_cache_key
    "user/#{current_user.nickname}/pull_requests"
  end
end
