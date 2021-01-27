# frozen_string_literal: true

class Survey < ActiveRecord::Base
  paginates_per 5

  has_many :question_groups
  belongs_to :employer
  has_many :survey_employee_connections
  has_many :employees, through: :survey_employee_connections

  accepts_nested_attributes_for :question_groups

  scope :filter_by_employer_id, ->(id) { where(employer_id: id) }
  scope :filter_avaible_by_assigned_employee_id, lambda { |assigned_employee_id|
    joins(:survey_employee_connections)
      .where(survey_employee_connections: { employee_id: assigned_employee_id, is_conducted: false })
  }
  scope :filter_conducted_by_assigned_employee_id, lambda { |assigned_employee_id|
    joins(:survey_employee_connections)
      .where(survey_employee_connections: { employee_id: assigned_employee_id, is_conducted: true })
  }

  validates_presence_of :label, :employer
  validates_associated :question_groups
  validates :question_groups, length: { minimum: 1 }
end
