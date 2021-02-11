# frozen_string_literal: true

class Option < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_one :option_statistic
  belongs_to :question

  accepts_nested_attributes_for :option_statistic

  after_initialize :init

  def init
    self.has_text_field = false if has_text_field.nil?
  end

  validates_presence_of :text, :question
end
