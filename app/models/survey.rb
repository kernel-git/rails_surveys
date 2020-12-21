class Survey < ActiveRecord::Base
  paginates_per 5

  has_many :question_groups
  belongs_to :client
  has_many :survey_user_relations
  has_many :users, through: :survey_user_relations
  validates :label, presence: true

  scope :filter_by_client_id, ->(id) { where(client_id: id) }
  scope :filter_avaible_by_assigned_user_id, ->(assigned_user_id) { joins(:survey_user_relations).where(survey_user_relations: { user_id: assigned_user_id, is_conducted: false }) }
  scope :filter_conducted_by_assigned_user_id, ->(assigned_user_id) { joins(:survey_user_relations).where(survey_user_relations: { user_id: assigned_user_id, is_conducted: true }) }

end
