class QuestionGroup < ActiveRecord::Base
  has_many :questions
  belongs_to :survey
  validates :label, presence: true
end
