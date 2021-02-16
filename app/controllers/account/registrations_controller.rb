# frozen_string_literal: true

class Account::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    logger.debug session["devise.omniauth_data"]
    @init_data = {}
    if session["devise.omniauth_data"].present?
      @init_data[:provider] = session["devise.omniauth_data"]['provider']
      @init_data[:uid] = session["devise.omniauth_data"]['uid']
      @init_data[:email] = session["devise.omniauth_data"]['email']
      @init_data[:password] = session["devise.omniauth_data"]['password']
      @init_data[:first_name] = session["devise.omniauth_data"]['first_name']
      @init_data[:last_name] = session["devise.omniauth_data"]['last_name']
    end

    @account = Account.new()

    logger.debug @init_data

    @employers_data = Employer.all.collect do |employer|
      [employer.id, employer.logo_url, employer.label, employer.public_email]
    end
  end

  # POST /resource
  def create
    @employee = Employee.new(employee_params)

    if @employee.save!
      sign_in @employee.account, event: :authentication
      redirect_to employee_root_url, notice: 'Employee created successfully'    
    else
      log_errors(@employee)
      redirect_to root_url, alert: 'Employee creation failed. Check logs...'
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the account wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def employee_params
    params.require(:employee).permit(
      :first_name,
      :last_name,
      :account_type,
      :age,
      :position_age,
      :opt_out,
      :employer_id,
      account_attributes: [
        :account_user_type,
        :email,
        :password,
        :password_confirmation,
        :provider,
        :uid
      ]
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   case params[:account][:account_type]
  #   when 'admin'
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  #   when 'employer'
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  #   when 'employee'
  #     devise_parameter_sanitizer.permit(:sign_up, keys:
  #       %i[first_name last_name age
  #          position_age account_type employer_id])
  #   end
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(_resource)
  #   '/employee/home'
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
