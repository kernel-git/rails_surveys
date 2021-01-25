# frozen_string_literal: true

class Employee < ActiveRecord::Base
  paginates_per 20

  validates_presence_of :first_name, :last_name, :account_type, :age, :position_age, :employer_id, :account
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates_associated :account

  belongs_to :employer
  has_and_belongs_to_many :segments
  has_many :survey_employee_relations
  has_many :surveys, through: :survey_employee_relations
  has_many :answers
  has_one :account, as: :account_user

  scope :filter_by_employer_id, ->(id) { where(employer_id: id) }
  scope :filter_avaible_by_survey_id, lambda { |survey_id|
    joins(:survey_employee_relations)
      .where(survey_employee_relations: { survey_id: survey_id, is_conducted: false })
  }
  scope :filter_conducted_by_survey_id, lambda { |survey_id|
    joins(:survey_employee_relations)
      .where(survey_employee_relations: { survey_id: survey_id, is_conducted: true })
  }
end
