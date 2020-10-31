class Answer < ActiveRecord::Base
    validates :answer_val, presence: true
    belongs_to :question
    belongs_to :user
end