# frozen_string_literal: true

##
# ApplicationRecord base class.
#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
