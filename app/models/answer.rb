class Answer < ActiveRecord::Base
  belongs_to :option
  belongs_to :employee

  # scope :filter_by_employee_id_and_survey_id, -> (employee_id, survey_id) do 
  #   joins(question: :question_group).where(question_groups: { survey_id: survey_id }, employee_id: employee_id)
  # end
end
