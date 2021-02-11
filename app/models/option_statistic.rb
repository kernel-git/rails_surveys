# frozen_string_literal: true

class OptionStatistic < ActiveRecord::Base
  belongs_to :option, dependent: :destroy

  validates_presence_of :option
end
