# frozen_string_literal: true

module GraphQL
  module Github
    module Entities
      ##
      # Author entity.
      # This class is mapping GraphQL result to a mapping model.
      #
      class Author
        ATTRS = %i[
          login
          avatar_url
          url
        ].freeze

        ATTRS.each { |attr| attr_reader attr }

        def initialize(data)
          @login = data.dig('login')
          @avatar_url = data.dig('avatarUrl')
          @url = data.dig('url')
        end
      end
    end
  end
end

