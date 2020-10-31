class User < ActiveRecord::Base
    validates :first_name, :last_name, :email, :password, :account_type, :age, :position_age, :opt_out
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is not an email" }
    validates :age, numericality: { only_integer: true, greater_than: 0}
    belongs_to :client
    has_and_belongs_to_many :segments
    has_many :answers
end