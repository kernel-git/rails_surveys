# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account_user, polymorphic: true, autosave: true

  def admin?
    account_user_type == 'Administrator'
  end

  def moderator?
    account_user_type == 'Moderator'
  end

  def employee?
    account_user_type == 'Employee'
  end

  validates_presence_of :account_user_type
end
