class Employer < ActiveRecord::Base
  paginates_per 10

  validates :public_email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }

  has_many :employees
  has_many :surveys
  has_and_belongs_to_many :segments
  has_one :account
end
