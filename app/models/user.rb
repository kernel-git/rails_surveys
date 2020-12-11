class User < ActiveRecord::Base
  paginates_per 25

  belongs_to :client
  has_and_belongs_to_many :segments
  has_and_belongs_to_many :surveys
  has_many :answers
  validates :first_name, :last_name, :email, :password, :account_type, :age, :position_age, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }
  validates :age, numericality: { only_integer: true, greater_than: 0 }

  scope :filter_by_client_id, ->(id) { where(client_id: id) }
end
