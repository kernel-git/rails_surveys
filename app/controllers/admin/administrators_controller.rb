# frozen_string_literal: true

class Admin::AdministratorsController < ApplicationController
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

  def edit; end

  def update
    if @administrator.update(administrator_params)
      redirect_to admin_administrator_url(@administrator), notice: 'Administrator updated successfully'
    else
      log_errors(@administrator)
      redirect_to edit_admin_administrator_url(@administrator), alert: 'Administrator update failed. Check logs...'
    end
  end

  def destroy
    if current_account.account_user == @administrator
      redirect_to admin_administrator_url(@administrator), notice: 'You can\'t delete yourself.'
      return
    end

    if @administrator.destroy
      redirect_to admin_administrators_url, notice: 'Administrator deleted successfully'
    else
      redirect_to admin_administrator_url(@administrator), notice: 'Administrator deletion failed. Check logs...'
    end
  end

  protected

  def administrator_params
    params.require(:administrator).permit(
      :nickname,
      account_attributes: %i[
        email
        password
        password_confirmation
      ]
    )
  end
end
