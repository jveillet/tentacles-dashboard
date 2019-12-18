# frozen_string_literal: true

##
# Collection of Dashboard helper methods.
#
module DashboardHelper
  include ApplicationHelper

  def build_query_string(repos)
    <<~STRING
      is:pr is:open created:>#{limit_date} #{build_repos(repos) unless repos.empty?} sort:created-asc
    STRING
  end

  def build_repos(repos)
    repos.map do |repo|
      "repo:#{repo}"
    end.join(' ')
  end

  def limit_date
    1.year.ago.strftime('%Y-01-01')
  end

  def user_repositories
    return [] unless current_user&.settings && current_user.settings.key?('repos')

    current_user.settings['repos'] || []
  end

  def user_defined_repositories?
    user_repositories.size.positive?
  end
end

