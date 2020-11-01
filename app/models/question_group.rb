class QuestionGroup < ActiveRecord::Base
    has_many :questions
    validates :label, presence: true
    belongs_to :survey
end