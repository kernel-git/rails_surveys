# frozen_string_literal: true

class Administrator < ApplicationRecord
  paginates_per 20

  validates_presence_of :nickname, :account
  validates_associated :account

  has_one :account, as: :account_user
end
