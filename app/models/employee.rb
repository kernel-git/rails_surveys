class Employee < ActiveRecord::Base
  paginates_per 20

  validates :first_name, :last_name, :account_type, :age, :position_age, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :employer
  has_and_belongs_to_many :segments
  has_many :survey_employee_relations
  has_many :surveys, through: :survey_employee_relations
  has_many :answers
  has_one :account

  scope :filter_by_employer_id, ->(id) { where(employer_id: id) }
  scope :filter_avaible_by_survey_id, ->(survey_id) { joins(:survey_employee_relations).where(survey_employee_relations: { survey_id: survey_id, is_conducted: false }) }
  scope :filter_conducted_by_survey_id, ->(survey_id) { joins(:survey_employee_relations).where(survey_employee_relations: { survey_id: survey_id, is_conducted: true }) }
end
