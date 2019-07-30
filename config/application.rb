require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
# require "action_mailer/railtie"
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

require 'graphql/client'
require 'graphql/client/http'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Tentacles
  ##
  # GraphQL Configuration
  #
  HTTPAdapter = GraphQL::Client::HTTP.new('https://api.github.com/graphql') do
    def headers(context)
      # Optionally set any HTTP headers
      token = "Bearer #{context[:access_token]}" if context[:access_token]
      {
        'User-Agent': 'Tentacles',
        'Authorization': token
      }
    end
  end

  Client = GraphQL::Client.new(
    schema: GraphQL::Client.load_schema('db/schema.json'),
    execute: HTTPAdapter
  )

  ##
  # Default Application config
  #
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.active_record.default_timezone = :local

    # RSpec and Factory Bot config
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
