# frozen_string_literal: true

class Admin::EmployeesController < ApplicationController
  layout 'admin'
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @employees = @employees.page(params[:page])
  end

  def show
    @employee = Employee.includes(:groups, :employer, answers: [
                                    question: [
                                      question_group: [:survey]
                                    ]
                                  ]).find(params[:id])
  end

  def new
    @groups_data = Group.all.collect do |group|
      [group.id,
      group.label]
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
    @groups_data = Group.all.collect do |group|
      [group.id,
      group.label]
    end
    @employers_data = Employer.all.collect do |employer|
      [employer.id,
       employer.logo_url,
       employer.label,
       employer.public_email]
    end
    @init_employer_id = @employee.employer.id
    @init_groups_ids = @employee.group_ids
  end

  def update
    if @employee.update(employee_params)
      redirect_to admin_employee_url(@employee), notice: 'Employee updated successfully'
    else
      redirect_to edit_admin_employee_url(@employee), alert: 'Employee update failed. Check logs...'
    end
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
      group_ids: []
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
