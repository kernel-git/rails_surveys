# frozen_string_literal: true

class Admin::EmployeesController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @employees = Employee.page(params[:page])
  end

  def show
    @employee = Employee.includes(:segments, :employer, answers: [
                                    question: [
                                      question_group: [:survey]
                                    ]
                                  ]).find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    log_exception(e)
    redirect_to(not_found_404_path)
  else
    @employee_employer = @employee.employer
    @employee_segments = @employee.segments
    @employee_answers = @employee.answers
  end

  def new
    @employee = Employee.new
    @segments_data = Segment.all.collect do |segment|
      [
        segment.id,
        segment.label
      ]
    end
    @employers_data = Employer.all.collect do |employer|
      [
        employer.id,
        employer.logo_url,
        employer.label,
        employer.public_email
      ]
    end
  end

  def create
    employee = Employee.new({
                              first_name: params[:employee][:first_name],
                              last_name: params[:employee][:last_name],
                              account_type: params[:employee][:account_type],
                              age: params[:employee][:age],
                              position_age: params[:employee][:position_age],
                              opt_out: params[:employee][:opt_out]
                            })
    employee.build_account(
      account_type: 'employee',
      email: params[:employee][:email],
      password: params[:employee][:password]
    )
    employee.employer = Employer.find(params[:employer_id])
    employee.segments = Segment.where(id: params[:segments_ids])

    employee.save!
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    log_exception(e)
    flash.alert = 'Employee creation failed. Check logs...'
    redirect_to(admin_employees_url)
  else
    flash.notice = 'Employee created successfully'
    redirect_to(admin_employee_url(@employee))
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
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
