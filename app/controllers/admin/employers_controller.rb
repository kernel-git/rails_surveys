# frozen_string_literal: true

class Admin::EmployersController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :create

  def index
    @employers = @employers.page(params[:page])
  end

  def show; end

  def new; end

  def create
    @employer = Employer.new(
      label: params[:employer][:label],
      logo_url: params[:employer][:logo_url],
      public_email: params[:employer][:public_email],
      address: params[:employer][:address],
      phone: params[:employer][:phone]
    )
    moderator = Moderator.new(
      nickname: params[:employer][:moderators_attributes][0][:nickname]
    )
    moderator.account = Account.new(
      email: params[:employer][:moderators_attributes][0][:account_attributes][:email],
      password: params[:employer][:moderators_attributes][0][:account_attributes][:password],
      password_confirmation: params[:employer][:moderators_attributes][0][:account_attributes][:password_confirmation]
    )
    @employer.moderators << moderator

    if @employer.save
      redirect_to admin_employer_url(@employer), notice: 'Employer created successfully'
    else
      log_errors(@employer)
      redirect_to new_admin_employer_url, alert: 'Employer creation failed. Check logs...'
    end
  end

  def edit; end

  def update
    if @employer.update(employer_params)
      redirect_to admin_employer_url(@employer), notice: 'Employer updated successfully'
    else
      log_errors(@employee)
      redirect_to edit_admin_employer_url(@employer), alert: 'Employer update failed. Check logs...'
    end
  end

  def destroy
    if @employer.destroy
      redirect_to admin_employers_url, notice: 'Employer deleted successfully'
    else
      redirect_to admin_employer_url(@employer), notice: 'Employer deletion failed. Check logs...'
    end
  end

  protected

  def employer_params
    params.require(:employer).permit(
      :logo_url,
      :label,
      :public_email,
      :address,
      :phone
    )
  end
end
