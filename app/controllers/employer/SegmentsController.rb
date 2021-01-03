class Employer::SegmentsController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @segments = Segment.all.page(params[:page])
  end
  def show
    id = Integer(params[:id])
    begin
      @segment = Segment.find(id)
    rescue ActiveRecord::RecordNotFound => e 
      render("employer/static_pages/not_found_404")
    else
      @segment_employees = @segment.employees      
    end
  end
  def new
    @segment = Segment.new
    @employees_data = Employee.all.collect { |employee| [employee.id, employee.first_name, employee.last_name, employee.account.email, employee.employer.label] }
    @employers_data = Employer.all.collect { |employer| [employer.id, employer.logo_url, employer.label, employer.public_email] }
  end
  def create
    @segment = Segment.new({
      label: params[:segment][:label]
    })
    @segment.employers << Employer.find(current_account.employer.id)
    @segment.employees = Employee.where(id: params[:employees_ids])
    if @segment.save
      redirect_to(employer_segment_url(@segment))
    else
      puts "Segment save failed. Error message: #{@segment.errors.full_messages}"
      redirect_to(employer_segments_url)
    end
  end
  def edit
    puts "Ping from admin/segments#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/segments#update with params: #{params}"
  end
  def destroy
    puts "Ping from admin/segments#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end