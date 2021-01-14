class Admin::EmployeesController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @employees = Employee.page(params[:page])
  end

  def show
    id = Integer(params[:id])
    begin
      @employee = Employee.includes(:segments, :employer, answers: [question: [question_group: [:survey]]]).find(id)
    rescue ActiveRecord::RecordNotFound => e
      redirect_to(not_found_404_path)
    else
      @employee_employer = @employee.employer
      @employee_segments = @employee.segments
      @employee_answers = @employee.answers
    end
  end

  def new
    @employee = Employee.new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
    @employers_data = Employer.all.collect { |employer| [employer.id, employer.logo_url, employer.label, employer.public_email] }
  end

  def create
    @employee = Employee.new({
                               first_name: params[:employee][:first_name],
                               last_name: params[:employee][:last_name],
                               account_type: params[:employee][:account_type],
                               age: params[:employee][:age],
                               position_age: params[:employee][:position_age],
                               opt_out: params[:employee][:opt_out]
                             })
    @account = Account.new({
                             account_type: 'employee',
                             email: params[:employee][:email],
                             password: params[:employee][:password]
                           })
    @employee.account = @account
    @employee.employer = Employer.find(params[:employer_id])
    @employee.segments = Segment.where(id: params[:segments_ids])
    if @employee.save
      if @account.save
        redirect_to(admin_employee_url(@employee))
      else
        puts "Account is not valid. Error message: #{@account.errors.full_messages}"
        redirect_to(admin_employees_url)
      end
    else
      puts "Employee is not valid. Error message: #{@employee.errors.full_messages}"
      redirect_to(admin_employees_url)
    end
  end

  def edit
    puts "Ping from admin/employees#edit with params: #{params}"
  end

  def update
    puts "Ping from admin/employees#update with params: #{params}"
  end

  def destroy
    puts "Ping from admin/employees#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
