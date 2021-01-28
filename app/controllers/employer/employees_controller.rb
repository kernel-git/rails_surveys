# frozen_string_literal: true

class Employer::EmployeesController < ApplicationController
  layout 'employer'
  load_and_authorize_resource

  def index
    @employees = @employees.page(params[:page])
  end

  def show
    @available_surveys = SurveyEmployeeConnection.filter_by_employee_id(@employee.id).filter_avaible
    @conducted_surveys = SurveyEmployeeConnection.filter_by_employee_id(@employee.id).filter_conducted
    logger.debug @employee.groups
  end

  def new
    @groups_data = Group.all.collect { |group| [group.id, group.label, group.created_at.to_formatted_s(:db)] }
  end

  def create
    # @employee.build_account(
    #   email: account_params[:email],
    #   password: account_params[:password],
    #   password_confirmation: account_params[:password]
    # )
    # logger.debug employee_params
    # logger.debug @employee.groups
    if @employee.save
      redirect_to employer_employee_url(@employee), notice: 'Employee created successfully'
    else
      log_errors(@employee)
      redirect_to new_employer_employee_url, alert: 'Employee creation failed. Check logs...'
    end
  end

  def edit
    @groups_data = Group.all.collect { |group| [group.id, group.label, group.created_at.to_formatted_s(:db)] }
    @init_groups_ids = @employee.group_ids
  end

  def update
    if @employee.update(employee_params)
      redirect_to employer_employee_url(@employee), notice: 'Employee updated successfully'
    else
      redirect_to edit_employer_employee_url(@employee), alert: 'Employee update failed. Check logs...'
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
      group_ids: [],
      account_attributes: [
        :email,
        :password
      ]
    )
  end
end
