class Admin::EmployersController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @employers = Employer.all.page(params[:page])
  end
  def show
    id = Integer(params[:id])
    begin
      @employer = Employer.find(id)
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    else
      @employers_employees = @employer.employees
      @employers_segments = @employer.segments
    end
  end
  def new
    @employer = Employer.new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
  end
  def create
    unless params[:employer][:logo_url].start_with?('http://')
      params[:employer][:logo_url] = 'http://' + params[:employer][:logo_url]
    end
    @employer = Employer.new({
      logo_url: params[:employer][:logo_url],
      label: params[:employer][:label],
      address: params[:employer][:address],
      public_email: params[:employer][:public_email],
      phone: params[:employer][:phone]
    })
    @employer.segments = Segment.where(id: params[:segments_ids])
    @account = Account.new({
      account_type: 'employer',
      email: params[:employer][:email],
      password: params[:employer][:password],
    })
    if @employer.valid? && @account.valid?
      begin
        @account.save!
        @employer.account = @account
        @employer.save!
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
        puts '--->EXEPTION DURING Employer/Account SAVE<---'
        puts "Exeption type: #{e.class.name}"
        puts "Exeption message: #{e.message}"
        puts '~~~~~~~Stack trace~~~~~~~'
        e.backtrace.each { |line| puts line }
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
        redirect_to(admin_employers_url)
      else
        redirect_to(admin_employer_url(@employer))
      end
    else
      puts "Employer save failed. Error message: #{@employer.errors.full_messages}"
      redirect_to(admin_employers_url)
    end
  end
  def edit
    puts "Ping from admin/employers#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/employers#update with params: #{params}"
  end
  def destroy
    puts "Ping from admin/employers#destroy with params: #{params}"
  end 
  def stats
    puts "Ping from admin/employers#stats"
  end
  def live
    puts "Ping from admin/employers#live"
  end
  def historical
    puts "Ping from admin/employers#historical"
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end

end