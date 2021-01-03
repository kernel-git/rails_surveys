class Question < ActiveRecord::Base
  has_many :answers
  has_many :options
  belongs_to :question_group
  validates :question_type, :benchmark_val, :benchmark_vol, presence: true
end
