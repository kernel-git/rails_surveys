# frozen_string_literal: true

class Moderator::GroupsController < ApplicationController
  load_and_authorize_resource

  def index
    @groups = @groups.page(params[:page])
  end

  def show
    @group_employees = @group.employees.filter_by_employer_id(current_account.account_user_id)
  end

  def new
    @employees_data = Employee.filter_by_employer_id(current_account.account_user.id).collect do |employee|
      [employee.id, employee.first_name, employee.last_name,
        employee.account.email, employee.account_type]
    end
  end

  def create
    if @group.save
      redirect_to moderator_group_url(@group), notice: 'Group created successfully'
    else
      log_errors(@group)
      redirect_to new_moderator_group_url, alert: 'Group creation failed. Check logs...'
    end
  end

  def edit
    @employees_data = Employee.filter_by_employer_id(current_account.account_user.id).collect do |employee|
      [employee.id, employee.first_name, employee.last_name,
        employee.account.email, employee.account_type]
    end
    @employees_init_ids = Employee.filter_by_employer_id(current_account.account_user_id)
      .filter_by_group_id(@group.id).collect { |employee| employee.id }
  end

  def update
    if @group.update(group_params)
      redirect_to moderator_group_url(@group), notice: 'Group updated successfully'
    else
      log_errors(@group)
      redirect_to edit_moderator_group_url(@group), alert: 'Group update failed. Check logs...'
    end
  end

  protected

  def group_params
    params.require(:group).permit(
      :label,
      employee_ids: []
    )
  end
end
