# frozen_string_literal: true

class Answer < ActiveRecord::Base
  validates :option_id, :employee_id, presence: true

  belongs_to :option
  belongs_to :employee

  scope :filter_by_option_id, -> (id) { where(option_id: id) }
  scope :filter_by_employee_id, -> (id) { where(employee_id: id) }
  scope :filter_by_option_id_and_employee_id, -> (option_id, employee_id) { filter_by_option_id(option_id).filter_by_employee_id(employee_id) }
end
