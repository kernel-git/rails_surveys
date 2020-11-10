class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :question_group
  validates :question_type, :benchmark_val, :benchmark_vol, presence: true
end
