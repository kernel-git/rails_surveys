# frozen_string_literal: true

class Administrator < ApplicationRecord
  paginates_per 20

  has_one :account, as: :account_user, dependent: :destroy

  accepts_nested_attributes_for :account

  validates_presence_of :nickname, :account
  validates_associated :account
end
