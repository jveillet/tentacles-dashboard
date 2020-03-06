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
          @created_at = data.dig('createdAt')
          @url = data.dig('url')
          @number = data.dig('number')
          @title = data.dig('title')
          @base_ref_name = data.dig('baseRefName')
          @author = Author.new(data.dig('author') || {})
          @commits = map_commits(data.dig('commits', 'nodes') || [])
          @base_repository = Repository.new(data.dig('baseRepository') || {})
        end

        private

        def map_commits(data)
          data.map do |node|
            Commit.new(node.dig('commit') || {})
          end
        end
      end
    end
  end
end

