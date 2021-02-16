class Account::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [:facebook, :google_oauth2]

  def facebook
    @relation = Account.filter_by_auth(request.env["omniauth.auth"])

    unless @relation.blank?
      sign_in @relation[0], event: :authentication
      redirect_to employee_root_url
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.omniauth_data"] = request.env["omniauth.auth"]['info']
      session["devise.omniauth_data"]['provider'] = request.env["omniauth.auth"]['provider']
      session["devise.omniauth_data"]['uid'] = request.env["omniauth.auth"]['uid']
      session["devise.omniauth_data"]['password'] = Devise.friendly_token[0,20]
      redirect_to new_account_registration_url
    end
  end

  def google_oauth2
    @relation = Account.filter_by_auth(request.env["omniauth.auth"])

    unless @relation.blank? 
      sign_in @relation[0], :event => :authentication 
      redirect_to employee_root_url
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.omniauth_data"] = request.env["omniauth.auth"]['info']
      session["devise.omniauth_data"]['provider'] = request.env["omniauth.auth"]['provider']
      session["devise.omniauth_data"]['uid'] = request.env["omniauth.auth"]['uid']
      session["devise.omniauth_data"]['password'] = Devise.friendly_token[0,20]
      redirect_to new_account_registration_url 
    end 
  end 

  def failure
    redirect_to root_path, alert: 'Omniauth failed. Check logs...'
  end

end