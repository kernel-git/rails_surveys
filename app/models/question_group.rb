# frozen_string_literal: true

class QuestionGroup < ActiveRecord::Base
  has_many :questions
  belongs_to :survey
  validates_presence_of :label, :survey
  validates_associated :questions
end
