# frozen_string_literal: true

class Admin::AdministratorsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  def index
    @administrators = @administrators.page(params[:page])
  end

  def show; end

  def new; end

  def create
    if @administrator.save
      redirect_to admin_administrator_url(@administrator), notice: 'Administrator created successfully'
    else
      log_errors(@administrator)
      redirect_to new_admin_administrator_url, alert: 'Administrator creation failed. Check logs...'
    end
  end

  def edit
  end

  def update
    if @administrator.update(administrator_params)
      redirect_to admin_administrator_url(@administrator), notice: 'Administrator updated successfully'
    else
      log_errors(@administrator)
      redirect_to edit_admin_administrator_url(@administrator), alert: 'Administrator update failed. Check logs...'
    end
  end

  def destroy
    Rails.logger.debug "Ping from admin/admins#destroy with params: #{params}"
  end

  protected

  def administrator_params
    params.require(:administrator).permit(
      :nickname,
      account_attributes: [
        :email,
        :password,
        :password_confirmation
      ]
    )
  end
end
