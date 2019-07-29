# frozen_string_literal: true

##
# Collection of Dashboard helper methods.
#
module DashboardHelper
  def build_query_string(repos)
    <<~STRING
      is:pr is:open created:>#{limit_date} #{repos.join(' ') unless repos.empty?} sort:created-asc
    STRING
  end

  def limit_date
    1.year.ago.strftime('%Y-01-01')
  end

  def user_repositories
    repos = ENV['GITHUB_REPOS'].to_s
    repos.split(',')
  end
end
