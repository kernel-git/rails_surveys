class Administrator < ApplicationRecord
  paginates_per 20

  validates :nickname, :account_id, presence: true

  belongs_to :account
end
