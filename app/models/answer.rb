# frozen_string_literal: true

class Answer < ActiveRecord::Base
  validates :option_id, :employee_id, presence: true

  belongs_to :option
  belongs_to :employee
end
