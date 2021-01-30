# frozen_string_literal: true

class Moderator < ApplicationRecord
  paginates_per 20

  belongs_to :employer
  has_one :account, as: :account_user

  accepts_nested_attributes_for :account

  validates_presence_of :nickname, :account, :employer
  validates_associated :account
end
