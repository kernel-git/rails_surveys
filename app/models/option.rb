# frozen_string_literal: true

class Option < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :question

  after_initialize :init

  def init
    self.has_text_field = false if has_text_field.nil?
  end

  validates_presence_of :text, :question
end
