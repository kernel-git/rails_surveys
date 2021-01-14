class Option < ApplicationRecord
  validates :text, :question_id, presence: true

  has_many :answers
  belongs_to :question
end
