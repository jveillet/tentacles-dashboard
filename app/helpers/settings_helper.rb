module SettingsHelper
  def map_repositories(query_results)
    repos = query_results&.data&.viewer&.repositories&.nodes.map { |repo| repo } || []
    query_results&.data&.viewer&.organizations&.nodes.each do |node|
      repos << node.repositories.nodes.map { |repo| repo } || []
    end

    repos.flatten
  end
end
