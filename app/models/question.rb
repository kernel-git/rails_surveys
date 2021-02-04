# frozen_string_literal: true

class Question < ActiveRecord::Base
  has_many :options, dependent: :destroy
  belongs_to :question_group

  accepts_nested_attributes_for :options

  validates_presence_of :question_type, :benchmark_val, :benchmark_vol, :question_group
  validates_associated :options
  validates :options, length: { minimum: 1 }
end
