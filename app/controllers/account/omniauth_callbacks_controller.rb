class Account::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :facebook

  def facebook
    # You need to implement the method below in your model (e.g. app/models/account.rb)
    @account = Account.from_facebook_auth(request.env["omniauth.auth"])

    logger.debug @account
    logger.debug @account.persisted?
    if @account.persisted?
      sign_in @account, event: :authentication
      redirect_to employee_root_url
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      session["devise.facebook_data"]['info']['password'] = Devise.friendly_token[0,20]
      redirect_to new_account_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

end