class QuestionGroup < ActiveRecord::Base
  has_many :questions
  belongs_to :survey
  validates :label, :survey_id, presence: true
end
