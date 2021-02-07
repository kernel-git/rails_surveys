# frozen_string_literal: true

class Employee < ActiveRecord::Base
  paginates_per 15

  belongs_to :employer
  has_and_belongs_to_many :groups, -> { distinct }
  has_many :survey_employee_connections, dependent: :destroy
  has_many :surveys, through: :survey_employee_connections
  has_many :answers, dependent: :destroy
  has_one :account, as: :account_user, dependent: :destroy

  accepts_nested_attributes_for :account

  scope :filter_by_employer_id, ->(id) { where(employer_id: id) }
  scope :filter_avaible_by_survey_id, lambda { |survey_id|
    joins(:survey_employee_connections)
      .where(survey_employee_connections: { survey_id: survey_id, is_conducted: false })
  }
  scope :filter_conducted_by_survey_id, lambda { |survey_id|
    joins(:survey_employee_connections)
      .where(survey_employee_connections: { survey_id: survey_id, is_conducted: true })
  }
  scope :filter_by_group_id, lambda { |group_id|
    joins(:employees_groups)
      .where(employees_groups: { employee_id: ids, group_id: group_id })
  }

  validates_presence_of :first_name, :last_name, :account_type, :age, :position_age, :employer_id, :account
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates_associated :account
end
