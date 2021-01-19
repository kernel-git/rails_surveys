# frozen_string_literal: true

class Employer::SegmentsController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @segments = Segment.all.page(params[:page])
  end

  def show
    id = params.require(:id)
    @segment = Segment.includes(:employees).find(id)
    rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing => e
      log_exception(e)
      redirect_to(employer_static_pages_url, page: 'not-found-404')
  end

  def new
    @segment = Segment.new
    @employees_data = Employee.filter_by_employer_id(current_account.employer.id).collect do |employee|
      [employee.id,
      employee.first_name,\
      employee.last_name,
      employee.account.email] 
    end
  end

  def create
    permitted_params = params.permit(segment: :label, employees_ids: [])
    logger.debug permitted_params
    segment = Segment.new({
                            label: permitted_params[:segment][:label]
                          })
    segment.employers << current_account.employer
    segment.employees = Employee.where(id: permitted_params[:employees_ids])

    segment.save!
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActionController::ParameterMissing => e
      log_exception(e)
      flash.alert = ('Segment creation failed. Check logs...')
      redirect_to(employer_segments_url)
    else
      flash.notice('Segment created successfully')
      redirect_to(employer_segment_url(segment))
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
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end
