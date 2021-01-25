# frozen_string_literal: true

class Admin::EmployeesController < ApplicationController
  layout 'admin'
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @employees = @employees.page(params[:page])
  end

  def show
    @employee = Employee.includes(:segments, :employer, answers: [
                                    question: [
                                      question_group: [:survey]
                                    ]
                                  ]).find(params[:id])
  end

  def new
    @segments_data = Segment.all.collect do |segment|
      [segment.id,
       segment.label]
    end
    @employers_data = Employer.all.collect do |employer|
      [employer.id,
       employer.logo_url,
       employer.label,
       employer.public_email]
    end
  end

  def create
    @employee.build_account(
      email: account_params[:email],
      password: account_params[:password]
    )
    if @employee.save
      redirect_to admin_employee_url(@employee), notice: 'Employee created successfully'
    else
      log_errors(@employee)
      redirect_to new_admin_employee_url, alert: 'Employee creation failed. Check logs...'
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
      :employer_id,
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
