class Administrator < ApplicationRecord
  paginates_per 20

  validates :nickname, presence: true

  has_one :account
end
