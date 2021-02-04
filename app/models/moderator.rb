# frozen_string_literal: true

class Moderator < ApplicationRecord
  paginates_per 20

  belongs_to :employer
  has_one :account, as: :account_user, dependent: :destroy

  accepts_nested_attributes_for :account

  scope :filter_by_employer_id, ->(id) { where(employer_id: id) }

  validates_presence_of :nickname, :account, :employer
  validates_associated :account
end
