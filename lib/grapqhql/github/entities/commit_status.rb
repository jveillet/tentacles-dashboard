# frozen_string_literal: true

module GraphQL
  module Github
    module Entities
      ##
      # Commit Status entity.
      # This class is mapping GraphQL result to a mapping model.
      #
      class CommitStatus
        ATTRS = %i[
          state
        ].freeze

        ATTRS.each { |attr| attr_reader attr }

        def initialize(data)
          @state = data['state']
        end
      end
    end
  end
end
