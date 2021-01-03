class Option < ApplicationRecord
  validates :text, presence: true
  
  has_many :answers
  belongs_to :question

end
