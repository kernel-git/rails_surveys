class Segment < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :clients
  validates :label, presence: true
end
