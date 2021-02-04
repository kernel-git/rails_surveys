# frozen_string_literal: true

class QuestionGroup < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  belongs_to :survey

  accepts_nested_attributes_for :questions

  validates_presence_of :label, :survey
  validates_associated :questions
  validates :questions, length: { minimum: 1 }
end
