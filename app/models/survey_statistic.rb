# frozen_string_literal: true

class SurveyStatistic < ActiveRecord::Base
  belongs_to :survey, dependent: :destroy

  validates_presence_of :survey
end
