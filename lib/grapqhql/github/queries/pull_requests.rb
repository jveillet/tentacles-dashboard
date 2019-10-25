# frozen_string_literal: true

require_relative '../entities/pull_request'

module GraphQL
  module Github
    module Queries
      ##
      # GraphQL Queries for pull requests
      #
      module PullRequests
        PullRequestsQuery = Tentacles::Client.parse <<-'GRAPHQL'
          query($queryString: String!, , $number_or_prs: Int!, $number_or_labels: Int!) {
             search(query: $queryString, type: ISSUE, last: $number_or_prs) {
               edges {
                 node {
                   ... on PullRequest {
                     author {
                       login
                       avatarUrl
                       url
                     }
                     labels(last: $number_or_labels) {
                       nodes {
                         color
                         name
                         url
                       }
                     }
                     number
                     url
                     title
                     createdAt
                     state
                     closed
                     headRefName
                     baseRefName
                     baseRepository { nameWithOwner }
                     commits(last: 1){
                       nodes {
                         commit {
                           commitUrl
                           abbreviatedOid
                           status {
                             state
                           }
                         }
                       }
                     }
                   }
                 }
               }
             }
          }
        GRAPHQL

        EXPIRES_IN = 5.minutes

        def self.fetch(cache_key:, variables:, context:)
          Rails.cache.fetch(cache_key, expires_in: EXPIRES_IN) do
            results = Tentacles::Client.query(
              PullRequestsQuery,
              variables: variables,
              context: context
            )
            return unless results.data.search.edges.any?

            results.data.search.edges.map do |pr|
              ::GraphQL::Github::Entities::PullRequest.new(pr.as_json.dig('data', 'node') || {})
            end
          end
        end
      end
    end
  end
end

