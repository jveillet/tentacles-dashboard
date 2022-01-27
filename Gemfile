# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Github social login
gem 'omniauth-github', '~> 2.0'
# CSRF mitigation for omniauth
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# GraphQL client
gem 'graphql-client', '~> 0.16.0'

# Use webpack to manage app-like JavaScript modules in Rails
gem 'webpacker', '~> 5.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.5', require: false

# Protect against typical web attacks, works with all Rack apps, including Rails.
gem 'rack-protection', '~> 2.1'

# Use Redis as cache store
gem 'redis', '~> 4.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2', '>= 5.2.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rails-controller-testing', '~> 1.0'
  # rspec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'rubocop-rails', '~> 2.11'
  gem 'rubocop-rspec', '~> 2.1'
  gem 'simplecov', require: false
end

group :development do
  # The Listen gem listens to file modifications and notifies you about the changes.
  gem 'listen', '~> 3.5', '>= 3.5.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.7.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
