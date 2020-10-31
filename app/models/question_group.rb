class QuestionGroup < ActiveRecord::Base
    has_many :questions
    validates :label
    belongs_to :survey
end