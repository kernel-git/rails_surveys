class Question < ActiveRecord::Base
  has_many :options
  belongs_to :question_group
  validates :question_type, :benchmark_val, :benchmark_vol, :question_group_id, presence: true
end
