# frozen_string_literal: true

##
# Dashboard controller.
#
class DashboardController < ApplicationController
  include DashboardHelper
  layout 'default'

  PullRequestsQuery = Tentacles::Client.parse <<-'GRAPHQL'
    query($queryString: String!, , $number_or_prs: Int!, $number_or_labels: Int!) {
      rateLimit {
        cost
        remaining
        resetAt
       }
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

  def index
    pull_requests = []

    unless user_repositories.empty?
      results = Tentacles::Client.query(
        PullRequestsQuery,
        variables: { queryString: build_query_string(user_repositories), number_or_prs: 100, number_or_labels: 10 },
        context: client_context
      )
      pull_requests = results&.data&.search&.edges
    end

    render 'dashboard/index', locals: {
      pull_requests: pull_requests
    }
  end
end
