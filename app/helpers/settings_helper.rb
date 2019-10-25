# frozen_string_literal: true

##
# Collection of Settings helper methods.
#
module SettingsHelper
  include ApplicationHelper

  def map_repositories(query_results)
    (map_user_repositories(query_results) + map_organizations_repositories(query_results)).flatten
  end

  def map_user_repositories(query_results)
    user_repos = query_results&.data&.viewer&.repositories&.nodes || []
    user_repos.map { |repo| repo }
  end

  def map_organizations_repositories(query_results)
    org_repos = query_results&.data&.viewer&.organizations&.nodes || []
    org_repos.map do |node|
      node.repositories.nodes.map { |repo| repo } || []
    end
  end

  def user_repositories
    return [] unless current_user&.settings && current_user.settings.key?('repos')

    current_user.settings['repos'] || []
  end
end
