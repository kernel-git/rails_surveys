class Client < ActiveRecord::Base
  paginates_per 10

  has_many :users
  has_many :surveys
  has_and_belongs_to_many :segments
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }
end
