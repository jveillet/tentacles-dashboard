# frozen_string_literal: true

require_relative 'author'
require_relative 'repository'
require_relative 'commit'

module GraphQL
  module Github
    module Entities
      ##
      # Pull Request Model.
      # This class is mapping GraphQL result to a mapping model..
      #
      class PullRequest
        ATTRS = %i[
          created_at
          url
          number
          commits
          base_repository
          base_ref_name
          title
          author
        ].freeze

        ATTRS.each { |attr| attr_reader attr }

        def initialize(data)
          @created_at = data['createdAt']
          @url = data['url']
          @number = data['number']
          @title = data['title']
          @base_ref_name = data['baseRefName']
          @author = Author.new(data['author'] || {})
          @commits = map_commits(data.dig('commits', 'nodes') || [])
          @base_repository = Repository.new(data['baseRepository'] || {})
        end

        private

        def map_commits(data)
          data.map do |node|
            Commit.new(node['commit'] || {})
          end
        end
      end
    end
  end
end
