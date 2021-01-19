# frozen_string_literal: true

class Segment < ActiveRecord::Base
  paginates_per 10

  has_and_belongs_to_many :employees
  has_and_belongs_to_many :employers
  validates :label, presence: true
end
