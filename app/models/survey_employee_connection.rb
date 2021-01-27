# frozen_string_literal: true

class SurveyEmployeeConnection < ActiveRecord::Base
  belongs_to :survey
  belongs_to :employee

  validates :survey_id, :employee_id, presence: true

  scope :filter_conducted, -> { where(is_conducted: true) }
  scope :filter_avaible, -> { where(is_conducted: false) }
  scope :filter_by_survey_id, ->(survey_id) { where(survey_id: survey_id) }
  scope :filter_by_employee_id, ->(employee_id) { where(employee_id: employee_id) }
  scope :filter_by_employer_id, ->(employer_id) { joins(:employee).where(employees: { employer_id: employer_id }) }
  scope :filter_conducted_by_employer_id, ->(employer_id) { filter_by_employer_id(employer_id).filter_conducted }
  scope :filter_conducted_by_employee_id, ->(employee_id) { filter_by_employee_id(employee_id).filter_conducted }
  scope :filter_avaible_by_employee_id, ->(employee_id) { filter_by_employee_id(employee_id).filter_avaible }
end
