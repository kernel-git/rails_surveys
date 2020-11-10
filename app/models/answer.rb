class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :answer_val, presence: true
end
