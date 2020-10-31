class Survey < ActiveRecord::Base
    validates :label, presence: true
    has_many :question_groups
    has_and_belongs_to_many :clients
end