# frozen_string_literal: true

class Option < ApplicationRecord
  validates_presence_of :text, :question

  has_many :answers
  belongs_to :question
end
