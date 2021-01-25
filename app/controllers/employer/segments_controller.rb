# frozen_string_literal: true

class Employer::SegmentsController < ApplicationController
  layout 'employer'
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @segments = @segments.page(params[:page])
  end

  def show
    @segment = Segment.includes(:employees).find(params[:id])
  end

  def new
    @employees_data = Employee.filter_by_employer_id(current_account.account_user.id).collect do |employee|
      [employee.id, employee.first_name,
       employee.last_name, employee.account.email]
    end
  end

  def create
    @segment.employers << current_account.account_user
    if @segment.save
      redirect_to employer_segment_url(@segment), notice: 'Segment created successfully'
    else
      log_errors(@segment)
      redirect_to new_employer_segment_url, alert: 'Segment creation failed. Check logs...'
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
      employee_ids: []
    )
  end
end
