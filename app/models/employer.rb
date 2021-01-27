# frozen_string_literal: true

class Employer < ActiveRecord::Base
  paginates_per 10

  validates_presence_of :label, :public_email, :phone, :address, :logo_url, :account
  validates :public_email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }
  validates_associated :account

  has_many :employees
  has_many :surveys
  has_and_belongs_to_many :groups
  has_one :account, as: :account_user
end
