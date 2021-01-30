# frozen_string_literal: true

class Employer < ActiveRecord::Base
  paginates_per 10

  has_many :employees
  has_many :surveys
  has_many :moderators

  validates_presence_of :label, :public_email, :phone, :address, :logo_url
  validates :public_email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }
  validates :moderators, length: { minimum: 1 }
end
