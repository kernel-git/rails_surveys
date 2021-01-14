class Employer::EmployeesController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @employees = Employee.filter_by_employer_id(current_account.employer.id).page(params[:page])
  end

  def show
    id = params[:id]
    begin
      @employee = Employee.includes(:segments, :employer, answers: [question: [question_group: [:survey]]]).find(id)
      render('employer/static_pages/not_found_404') if @employee.employer.id != current_account.employer.id
    rescue ActiveRecord::RecordNotFound => e
      render('employer/static_pages/not_found_404')
    else
      @employee_employer = @employee.employer
      @employee_segments = @employee.segments
      @employee_answers = @employee.answers
    end
  end

  def new
    @employee = Employee.new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
  end

  def create
    @employee = Employee.new({
                               first_name: params[:employee][:first_name],
                               last_name: params[:employee][:last_name],
                               email: params[:employee][:email],
                               account_type: params[:employee][:account_type],
                               password: params[:employee][:password],
                               age: params[:employee][:age],
                               position_age: params[:employee][:position_age],
                               opt_out: params[:employee][:opt_out]
                             })
    @employee.employer = Employer.find(current_account.employer.id)
    @employee.segments = Segment.where(id: params[:segments_ids])
    if @employee.save
      redirect_to(employer_employee_url(@employee))
    else
      puts "Employee save failed. Error message: #{@employee.errors.full_messages}"
      redirect_to(employer_employees_url)
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
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end
