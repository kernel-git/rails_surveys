# frozen_string_literal: true

class Group < ActiveRecord::Base
  paginates_per 10

  has_and_belongs_to_many :employees, -> { distinct }

  validates_presence_of :label
end
