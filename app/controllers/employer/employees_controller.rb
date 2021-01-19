# frozen_string_literal: true

class Employer::EmployeesController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @employees = Employee.filter_by_employer_id(current_account.employer.id).page(params[:page])
  end

  def show
    id = params.require(:id)
    @employee = Employee.includes(:segments, :employer, survey_employee_relations: :survey).find(id)
    if @employee.employer.id != current_account.employer.id
      redirect_to(employer_static_pages_url, page: 'not-found-404')
    end
    rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing => e
      log_exception(e)
      redirect_to(employer_static_pages_url, page: 'not-found-404')
  end

  def new
    @employee = Employee.new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
  end

  def create
    employee_params = params.require(:employee).permit(
      :first_name, :last_name, :age, :email, 
      :account_type, :password, :position_age, :opt_out
    )
    segments_ids = params.require(:segments_ids)

    account = Account.new({
      account_type: 'employee',
      email: employee_params[:email],
      password: employee_params[:password]
    })
    account.build_employee(
      first_name: employee_params[:first_name],
      last_name: employee_params[:last_name],
      account_type: employee_params[:account_type],
      age: employee_params[:age],
      position_age: employee_params[:position_age],
      opt_out: employee_params[:opt_out]
    )

    logger.debug account
    logger.debug account.employee

    account.employee.employer = current_account.employer
    account.employee.segments = Segment.where(id: segments_ids)

    account.save!
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    log_exception(e)
    flash.alert = 'Employee creation failed. Check logs...'
    redirect_to(employer_employees_url)
  else
    flash.notice = 'Employee created successfully'
    redirect_to(employer_employee_url(account.employee))
  end

  def edit
    Rails.logger.debug "Ping from admin/employees#edit with params: #{params}"
  end

  def update
    Rails.logger.debug "Ping from admin/employees#update with params: #{params}"
  end

  def destroy
    Rails.logger.debug "Ping from admin/employees#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end
