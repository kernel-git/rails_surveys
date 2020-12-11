class Survey < ActiveRecord::Base
  has_many :question_groups
  has_and_belongs_to_many :clients
  has_and_belongs_to_many :users
  validates :label, presence: true
end
