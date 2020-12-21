class Segment < ActiveRecord::Base
  paginates_per 10

  has_and_belongs_to_many :users
  has_and_belongs_to_many :clients
  validates :label, presence: true
end
