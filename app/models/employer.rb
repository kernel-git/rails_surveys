# frozen_string_literal: true

class Employer < ActiveRecord::Base
  paginates_per 10

  has_many :employees
  has_many :surveys
  has_one :account, as: :account_user

  accepts_nested_attributes_for :account

  validates_presence_of :label, :public_email, :phone, :address, :logo_url, :account
  validates :public_email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }
  validates_associated :account
end
