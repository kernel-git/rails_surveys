# frozen_string_literal: true

class Employer::EmployeesController < ApplicationController
  layout 'employer'
  load_and_authorize_resource

  def index
    @employees = @employees.page(params[:page])
  end

  def show; end

  def new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
  end

  def create
    @employee.build_account(
      email: account_params[:email],
      password: account_params[:password],
      password_confirmation: account_params[:password]
    )
    if @employee.save
      redirect_to employer_employee_url(@employee), notice: 'Employee created successfully'
    else
      log_errors(@employee)
      redirect_to new_employer_employee_url, alert: 'Employee creation failed. Check logs...'
    end
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

  def employee_params
    params.require(:employee).permit(
      :first_name,
      :last_name,
      :account_type,
      :age,
      :position_age,
      :opt_out,
      segment_ids: []
    )
  end

  def account_params
    params.require(:employee).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
