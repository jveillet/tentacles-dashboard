# frozen_string_literal: true

##
# Settings COntroller.
# This file fetches the organizations and Repositories from GitHub's GraphQL API.
#
class SettingsController < ApplicationController
  include SettingsHelper
  layout 'default'

  OrganizationsQuery = Tentacles::Client.parse <<-'GRAPHQL'
    query($last_orgs:Int!, $last_repos:Int!){
      viewer {
        name
        login
        avatarUrl
        url
        repositories(last: $last_repos) {
          totalCount
          nodes {
            name
            isPrivate
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
              }
            }
          }
        }
      }
    }
  GRAPHQL

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
end
