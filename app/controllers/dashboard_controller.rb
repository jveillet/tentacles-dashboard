# frozen_string_literal: true

require './lib/grapqhql/github/queries/pull_requests'

##
# Dashboard controller.
#
class DashboardController < ApplicationController
  include DashboardHelper
  include ActionView::Helpers::DateHelper
  layout 'default'
  before_action :authenticate_user!

  NUMBER_OF_PULL_REQUESTS = 100
  NUMBER_OF_LABELS = 5

  def index
    return render 'dashboard/empty' unless user_defined_repositories?

    variables = {
      queryString: build_query_string(user_repositories),
      number_or_prs: NUMBER_OF_PULL_REQUESTS,
      number_or_labels: NUMBER_OF_LABELS
    }

    pull_requests = ::GraphQL::Github::Queries::PullRequests.fetch(
      cache_key: pr_cache_key,
      variables: variables,
      context: client_context
    )

    if pull_requests.blank?
      render 'dashboard/empty'
    else
      render 'dashboard/index', locals: {
        pull_requests: pull_requests
      }
    end
  end

  def refresh
    variables = {
      queryString: build_query_string(user_repositories),
      number_or_prs: NUMBER_OF_PULL_REQUESTS,
      number_or_labels: NUMBER_OF_LABELS
    }

    pull_requests = ::GraphQL::Github::Queries::PullRequests.fetch(
      cache_key: pr_cache_key,
      variables: variables,
      context: client_context
    )

    render json: { pull_requests: pull_requests }, content_type: 'application/json', status: :ok
  end
end

