class Employer < ActiveRecord::Base
  paginates_per 10

  validates :label, :public_email, :phone, :address, :logo_url, :account_id, presence: true
  validates :public_email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }

  has_many :employees
  has_many :surveys
  has_and_belongs_to_many :segments
  belongs_to :account
end
