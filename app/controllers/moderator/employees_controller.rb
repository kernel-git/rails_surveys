# frozen_string_literal: true

class Moderator::EmployeesController < ApplicationController
  load_and_authorize_resource

  def index
    @employees = @employees.page(params[:page])
  end

  def show
    @available_surveys = SurveyEmployeeConnection.filter_by_employee_id(@employee.id).filter_avaible
    @conducted_surveys = SurveyEmployeeConnection.filter_by_employee_id(@employee.id).filter_conducted
  end

  def new
    @groups_data = Group.all.collect { |group| [group.id, group.label, group.created_at.to_formatted_s(:db)] }
  end

  def create
    if @employee.save
      redirect_to moderator_employee_url(@employee), notice: 'Employee created successfully'
    else
      log_errors(@employee)
      redirect_to new_moderator_employee_url, alert: 'Employee creation failed. Check logs...'
    end
  end

  def edit
    @groups_data = Group.all.collect { |group| [group.id, group.label, group.created_at.to_formatted_s(:db)] }
    @init_groups_ids = @employee.group_ids
  end

  def update
    if @employee.update(employee_params)
      redirect_to moderator_employee_url(@employee), notice: 'Employee updated successfully'
    else
      log_errors(@employee)
      redirect_to edit_moderator_employee_url(@employee), alert: 'Employee update failed. Check logs...'
    end
  end

  def destroy
    if @employee.destroy
      redirect_to moderator_employees_url, notice: 'Employee deleted successfully'
    else
      redirect_to moderator_employee_url(@employee), notice: 'Employee deletion failed. Check logs...'
    end
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
      account_attributes: %i[
        email
        password
      ]
    )
  end
end
