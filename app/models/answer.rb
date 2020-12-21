class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :answer_val, presence: true

  scope :filter_by_user_id_and_survey_id, -> (user_id, survey_id) do 
    joins(question: :question_group).where(question_groups: { survey_id: survey_id }, user_id: user_id)
  end
end
