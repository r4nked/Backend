# frozen_string_literal: true

# @abstract
#
# Abstract superclass for all models in the application.

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
