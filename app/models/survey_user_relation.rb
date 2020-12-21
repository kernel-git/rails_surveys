class SurveyUserRelation < ActiveRecord::Base
  belongs_to :survey
  belongs_to :user

  scope :filter_conducted, -> { where(is_conducted: true) }
  scope :filter_avaible, -> { where(is_conducted: false) }
  scope :filter_by_survey_id, -> (survey_id) { where(survey_id: survey_id) }
  scope :filter_by_user_id, -> (user_id) { where(user_id: user_id) }
  scope :filter_by_client_id, -> (client_id) { joins(:user).where(users: {client_id: client_id } ) }
  scope :filter_conducted, -> { where( is_conducted: true ) }
  scope :filter_conducted_by_client_id, -> (client_id) { filter_by_client_id(client_id).filter_conducted }
end