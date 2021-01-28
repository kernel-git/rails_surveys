# frozen_string_literal: true

class Employer::GroupsController < ApplicationController
  layout 'employer'
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @groups = @groups.page(params[:page])
  end

  def show
    @group = Group.includes(:employees).find(params[:id])
    @group_employees = Employee.filter_by_employer_id(current_account.account_user_id).filter_by_group_id(@group.id)
  end

  def new
    @employees_data = Employee.filter_by_employer_id(current_account.account_user.id).collect do |employee|
      [employee.id, employee.first_name, employee.last_name, 
        employee.account.email, employee.account_type]
    end
  end

  def create
    @group.employers << current_account.account_user
    if @group.save
      redirect_to employer_group_url(@group), notice: 'Group created successfully'
    else
      log_errors(@group)
      redirect_to new_employer_group_url, alert: 'Group creation failed. Check logs...'
    end
  end

  def edit
    Rails.logger.debug "Ping from admin/groups#edit with params: #{params}"
  end

  def update
    Rails.logger.debug "Ping from admin/groups#update with params: #{params}"
  end

  def destroy
    Rails.logger.debug "Ping from admin/groups#destroy with params: #{params}"
  end

  protected

  def group_params
    params.require(:group).permit(
      :label,
      employee_ids: []
    )
  end
end