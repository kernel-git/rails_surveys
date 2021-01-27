# frozen_string_literal: true

class Admin::GroupsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @groups = @groups.page(params[:page])
  end

  def show
    @group = Group.includes(:employees, :employers).find(params[:id])
  end

  def new
    @employees_data = Employee.all.collect do |employee|
      [employee.id, employee.first_name, employee.last_name,
       employee.account.email, employee.employer.label]
    end
    @employers_data = Employer.all.collect do |employer|
      [employer.id, employer.logo_url,
       employer.label, employer.public_email]
    end
  end

  def create
    if @group.save
      redirect_to admin_group_url(@group), notice: 'Group created successfully'
    else
      log_errors(@group)
      redirect_to new_admin_group_url, alert: 'Group creation failed. Check logs...'
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
      employee_ids: [],
      employer_ids: []
    )
  end
end
