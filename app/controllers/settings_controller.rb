# frozen_string_literal: true

##
# Settings COntroller.
# This file fetches the organizations and Repositories from GitHub's GraphQL API.
#
class SettingsController < ApplicationController
  include SettingsHelper
  layout 'default'
  before_action :authenticate_user!

  OrganizationsQuery = Tentacles::Client.parse <<-'GRAPHQL'
    query($last_orgs:Int!, $last_repos:Int!){
      viewer {
        name
        login
        avatarUrl
        url
        repositories(last: $last_repos, affiliations:OWNER) {
          totalCount
          nodes {
            name
            isPrivate
            nameWithOwner
          }
        }
        organizations(last: $last_orgs) {
          totalCount
          nodes {
            name
            avatarUrl
            login
            url
            viewerIsAMember
            repositories(last: $last_repos) {
              totalCount
              nodes {
                name
                isPrivate
                nameWithOwner
              }
            }
          }
        }
      }
    }
  GRAPHQL

  ##
  # Retrieve and display the settings for a user.
  # This method fetches organization, user profile, and repositories.
  #
  def index
    results = Tentacles::Client.query(
      OrganizationsQuery,
      variables: { last_orgs: 10, last_repos: 100 },
      context: client_context
    )
    repos = map_repositories(results)

    render 'settings/index', locals: {
      viewer: results.data.viewer,
      repos: repos
    }
  end

  ##
  # Save settings of the user.
  # This method save the repositories into the database so that users are able
  # to retrieve their preferencies.
  #
  def create
    repos = params[:repo] || []
    settings = { repos: repos }
    @user = current_user

    if @user.update(settings: settings)
      render json: {}, content_type: 'application/json', status: :ok
    else
      render json: {
        message: 'An error occured while saving your settings. Please try again later.'
      }, status: :bad_request
    end
  end
end
