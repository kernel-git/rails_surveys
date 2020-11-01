class Client < ActiveRecord::Base
    validates :label, :email, :phone, :address, :logo_url, presence: true
    validates :phone, numericality: { only_integer: true }
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is not an email" }
    has_one :user
    has_and_belongs_to_many :surveys
    has_and_belongs_to_many :segments
end