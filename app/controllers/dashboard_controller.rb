# frozen_string_literal: true

##
# Dashboard controller.
#
class DashboardController < ApplicationController
  include DashboardHelper
  include ActionView::Helpers::DateHelper
  layout 'default'
  before_action :authenticate_user!

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

  def index
    if user_defined_repositories?
      results = Tentacles::Client.query(
        PullRequestsQuery,
        variables: { queryString: build_query_string(user_repositories), number_or_prs: 100, number_or_labels: 10 },
        context: client_context
      )
      pull_requests = results&.data&.search&.edges

      render 'dashboard/index', locals: {
        pull_requests: pull_requests
      }
    else
      render 'dashboard/empty'
    end
  end

  def refresh
    pull_requests = []

    if user_defined_repositories?
      results = Tentacles::Client.query(
        PullRequestsQuery,
        variables: { queryString: build_query_string(user_repositories), number_or_prs: 100, number_or_labels: 10 },
        context: client_context
      )
      pull_requests = results&.data&.search&.edges
    end

    render json: { pull_requests: pull_requests }, content_type: 'application/json', status: :ok
  end
end
