class Segment < ActiveRecord::Base
    validates :label, presence: true
    has_and_belongs_to_many :users
    has_and_belongs_to_many :clients
end