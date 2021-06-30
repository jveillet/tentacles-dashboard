# frozen_string_literal: true

module GraphQL
  module Github
    module Entities
      ##
      # Repository entity.
      # This class is mapping GraphQL result to a mapping model.
      #
      class Repository
        ATTRS = %i[
          name_with_owner
          name
        ].freeze

        ATTRS.each { |attr| attr_reader attr }

        def initialize(data)
          @name = data['name']
          @name_with_owner = data['nameWithOwner']
        end
      end
    end
  end
end
