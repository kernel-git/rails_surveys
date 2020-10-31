class Question < ActiveRecord::Base
    has_many :answers
    validates :question_type, :benchmark_val, :benchmark_vol, presence: true
    belongs_to :question_group
end