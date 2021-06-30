# frozen_string_literal: true

require_relative 'commit_status'

module GraphQL
  module Github
    module Entities
      ##
      # Commit entity.
      # This class is mapping GraphQL result to a mapping model.
      #
      class Commit
        ATTRS = %i[
          commit_url
          abbrevation_oid
          status
        ].freeze

        ATTRS.each { |attr| attr_reader attr }

        def initialize(data)
          @commit_url = data['commitUrl']
          @abbrevation_oid = data['abbreviatedOid']
          @status = CommitStatus.new(data['status'] || {})
        end
      end
    end
  end
end
