# frozen_string_literal: true
class ApplicationRecord < ActiveRecord::Base
  cattr_accessor :params
  self.abstract_class = true
end
