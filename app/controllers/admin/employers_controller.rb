# frozen_string_literal: true

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
      log_exception(e)
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
      params[:employer][:logo_url] = "http://#{params[:employer][:logo_url]}"
    end
    employer = Employer.new({
                              logo_url: params[:employer][:logo_url],
                              label: params[:employer][:label],
                              address: params[:employer][:address],
                              public_email: params[:employer][:public_email],
                              phone: params[:employer][:phone]
                            })
    employer.segments = Segment.where(id: params[:segments_ids])
    employer.build_account(
      account_type: 'employer',
      email: params[:employer][:email],
      password: params[:employer][:password]
    )
    employer.save!
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    log_exception(e)
    flash.alert = ('Employer creation failed. Check logs...')
    redirect_to(admin_employers_url)
  else
    flash.info('Employer created successfully')
    redirect_to(admin_employer_url(employer))
  end

  def edit
    Rails.logger.debug "Ping from admin/employers#edit with params: #{params}"
  end

  def update
    Rails.logger.debug "Ping from admin/employers#update with params: #{params}"
  end

  def destroy
    Rails.logger.debug "Ping from admin/employers#destroy with params: #{params}"
  end

  def stats
    Rails.logger.debug 'Ping from admin/employers#stats'
  end

  def live
    Rails.logger.debug 'Ping from admin/employers#live'
  end

  def historical
    Rails.logger.debug 'Ping from admin/employers#historical'
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
