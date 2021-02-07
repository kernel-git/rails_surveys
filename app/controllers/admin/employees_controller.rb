# frozen_string_literal: true

class Admin::EmployeesController < ApplicationController
  load_and_authorize_resource

  def index
    @employees = @employees.page(params[:page])
  end

  def show
    @results = SurveyEmployeeConnection.filter_by_employee_id(@employee.id).filter_conducted
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
      log_errors(@employee)
      redirect_to edit_admin_employee_url(@employee), alert: 'Employee update failed. Check logs...'
    end
  end

  def destroy
    if @employee.destroy
      redirect_to admin_employees_url, notice: 'Employee deleted successfully'
    else
      redirect_to admin_employee_url(@employee), notice: 'Employee deletion failed. Check logs...'
    end
  end

  def search
    if params[:search].blank?
      redirect_to admin_surveys_url, alert: 'Search field empty'
    else
      @search_results = Employee.all.joins(:account)
        .where('lower(first_name) LIKE :search_text OR 
                  lower(last_name) LIKE :search_text OR
                  lower(account_type) LIKE :search_text OR
                  lower(age) LIKE :search_text OR
                  lower(position_age) LIKE :search_text OR
                  lower(accounts.email) LIKE :search_text', 
                  search_text: "%#{params[:search].downcase}%").page(params[:page])
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
      :employer_id,
      group_ids: [],
      account_attributes: %i[
        email
        password
      ]
    )
  end
end
