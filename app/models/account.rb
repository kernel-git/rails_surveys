# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  belongs_to :account_user, polymorphic: true, autosave: true

  def administrator?
    account_user_type == 'Administrator'
  end

  def moderator?
    account_user_type == 'Moderator'
  end

  def employee?
    account_user_type == 'Employee'
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |account|
  #     account.email = auth.info.email
  #     account.password = Devise.friendly_token[0, 20]
  #     account.account_user_type = 'Employee'
  #   end
  # end

  # def self.new_with_session(params, session)
  #   super.tap do |account|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       logger.debug session["devise.facebook_data"]
  #       account.email = data["email"] if account.email.blank?
  #       byebug
  #       # employee = Employee.new({
  #       #                       first_name: params[:employee][:first_name],
  #       #                       last_name: params[:employee][:last_name],
  #       #                       account_type: params[:employee][:account_type],
  #       #                       age: params[:employee][:age],
  #       #                       position_age: params[:employee][:position_age],
  #       #                       opt_out: false
  #       #                     })
  #     end
  #   end
  # end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session[“devise.facebook_data”] && session[“devise.facebook_data”][“extra”][“raw_info”]
  #       user.email = data[“email”] if user.email.blank?
  #     end
  #   end
  # end

  # def self.from_facebook_auth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #   end
  # end

  scope :filter_by_auth, ->(auth) { where(provider: auth.provider, uid: auth.uid) }

  validates_presence_of :account_user_type
end
