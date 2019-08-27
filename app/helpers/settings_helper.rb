# frozen_string_literal: true

##
# Collection of Settings helper methods.
#
module SettingsHelper
  def map_repositories(query_results)
    user_repos = query_results&.data&.viewer&.repositories&.nodes || []
    repos = user_repos.map { |repo| repo }
    org_repos = query_results&.data&.viewer&.organizations&.nodes || []
    org_repos.each do |node|
      repos << node.repositories.nodes.map { |repo| repo } || []
    end

    repos.flatten
  end
end
