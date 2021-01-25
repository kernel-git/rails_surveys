# frozen_string_literal: true

class Admin::SegmentsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @segments = @segments.page(params[:page])
  end

  def show
    @segment = Segment.includes(:employees, :employers).find(params[:id])
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
    if @segment.save
      redirect_to admin_segment_url(@segment), notice: 'Segment created successfully'
    else
      log_errors(@segment)
      redirect_to new_admin_segment_url, alert: 'Segment creation failed. Check logs...'
    end
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

  def segment_params
    params.require(:segment).permit(
      :label,
      employee_ids: [],
      employer_ids: []
    )
  end
end
