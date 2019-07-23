require 'graphql/client'
require 'graphql/client/http'

HTTP = GraphQL::Client::HTTP.new('https://api.github.com/graphql') do
  def headers(context)
    # Optionally set any HTTP headers
    {
      'User-Agent': 'Tentacles',
      'Authorization' => "Bearer #{ENV['GITHUB_ACCESS_TOKEN']}"
    }
  end
end

namespace :schema do
   task :update do
      GraphQL::Client.dump_schema(HTTP, "db/schema.json")
   end
end
