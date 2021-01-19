# frozen_string_literal: true

class Question < ActiveRecord::Base
  has_many :options
  belongs_to :question_group
  validates_presence_of :question_type, :benchmark_val, :benchmark_vol, :question_group
end
