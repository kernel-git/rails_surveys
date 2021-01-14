# frozen_string_literal: true

class Account::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @account = Account.new
    @employers_data = Employer.all.collect { |employer| [employer.id, employer.logo_url, employer.label, employer.public_email] }
    super
  end

  # POST /resource
  def create
    puts 'ping from account/registrations#create'
    puts params
    params[:account][:account_type] = 'employee'
    params[:employee][:position_age] = 1
    @employee = Employee.new({
                               first_name: params[:employee][:first_name],
                               last_name: params[:employee][:last_name],
                               account_type: params[:employee][:account_type],
                               age: params[:employee][:age],
                               position_age: params[:employee][:position_age],
                               opt_out: params[:employee][:opt_out]
                             })
    @account = Account.new({
                             account_type: 'employee',
                             email: params[:account][:email],
                             password: params[:account][:password]
                           })
    @employee.account = @account
    puts params[:employee][:employer_id]
    employer = Employer.find(params[:employee][:employer_id])
    puts @employee.valid?
    @employee.employer = employer
    puts @employee.valid?
    if @employee.valid? && @account.valid?
      @employee.save
      super
    else
      puts "Employee/Account is not valid. Error message: #{@employee.errors.full_messages} #{@account.errors.full_messages}"
      redirect_to(account_root)
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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    case params[:account][:account_type]
    when 'admin'
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    when 'employer'
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    when 'employee'
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name
                                                           age position_age employer_id])
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end