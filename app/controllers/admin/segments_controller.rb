# frozen_string_literal: true

class Admin::SegmentsController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @segments = Segment.all.page(params[:page])
  end

  def show
    id = Integer(params[:id])
    begin
      @segment = Segment.find(id)
    rescue ActiveRecord::RecordNotFound => e
      log_exception(e)
      redirect_to(not_found_404_path)
    else
      @segment_employers = @segment.employers
      @segment_employees = @segment.employees
    end
  end

  def new
    @segment = Segment.new
    @employees_data = Employee.all.collect do |employee|
      [
        employee.id,
        employee.first_name,
        employee.last_name,
        employee.account.email,
        employee.employer.label
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
    @segment = Segment.new({
                             label: params[:segment][:label]
                           })
    @segment.employers = Employer.where(id: params[:employers_ids])
    @segment.employees = Employee.where(id: params[:employees_ids])
    @segment.save!
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    log_exception(e)
    flash.alert = ('Segment creation failed. Check logs...')
    redirect_to(admin_segments_url)
  else
    flash.info('Segment created successfully')
    redirect_to(admin_segment_url(@segment))
  end

  def edit
    Rails.logger.debug "Ping from admin/segments#edit with params: #{params}"
  end

  def update
    Rails.logger.debug "Ping from admin/segments#update with params: #{params}"
  end

  def destroy
    Rails.logger.debug "Ping from admin/segments#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
