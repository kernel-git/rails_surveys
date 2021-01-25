# frozen_string_literal: true

class Admin::EmployersController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  def index
    @employers = @employers.page(params[:page])
  end

  def show; end

  def new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
  end

  def create
    @employer.build_account(
      email: account_params[:email],
      password: account_params[:password],
      password_confirmation: account_params[:password]
    )
    if @employer.save
      redirect_to admin_employer_url(@employer), notice: 'Employer created successfully'
    else
      log_errors(@employer)
      redirect_to new_admin_employer_url, alert: 'Employer creation failed. Check logs...'
    end
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

  def employer_params
    params.require(:employer).permit(
      :logo_url,
      :label,
      :public_email,
      :address,
      :phone,
      segment_ids: []
    )
  end

  def account_params
    params.require(:employer).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
