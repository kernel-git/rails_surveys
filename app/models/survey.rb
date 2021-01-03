class Survey < ActiveRecord::Base
  paginates_per 5

  has_many :question_groups
  belongs_to :employer
  has_many :survey_employee_relations
  has_many :employees, through: :survey_employee_relations
  validates :label, presence: true

  scope :filter_by_employer_id, ->(id) { where(employer_id: id) }
  scope :filter_avaible_by_assigned_employee_id, ->(assigned_employee_id) { joins(:survey_employee_relations).where(survey_employee_relations: { employee_id: assigned_employee_id, is_conducted: false }) }
  scope :filter_conducted_by_assigned_employee_id, ->(assigned_employee_id) { joins(:survey_employee_relations).where(survey_employee_relations: { employee_id: assigned_employee_id, is_conducted: true }) }

end
