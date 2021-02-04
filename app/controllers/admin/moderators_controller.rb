# frozen_string_literal: true

class Admin::ModeratorsController < ApplicationController
  load_and_authorize_resource

  def index
    @moderators = @moderators.page(params[:page])
  end

  def show
  end

  def new
    @employers_data = Employer.all.collect do |employer|
      [employer.id,
       employer.logo_url,
       employer.label,
       employer.public_email]
    end
  end

  def create
    if @moderator.save
      redirect_to admin_moderator_url(@moderator), notice: 'Moderator created successfully'
    else
      log_errors(@moderator)
      redirect_to new_admin_moderator_url, alert: 'Moderator creation failed. Check logs...'
    end
  end

  def edit
    @employers_data = Employer.all.collect do |employer|
      [employer.id,
       employer.logo_url,
       employer.label,
       employer.public_email]
    end
    @init_employer_id = @moderator.employer.id
  end

  def update
    if @moderator.update(moderator_params)
      redirect_to admin_moderator_url(@moderator), notice: 'Moderator updated successfully'
    else
      log_errors(@moderator)
      redirect_to edit_admin_moderator_url(@moderator), alert: 'Moderator update failed. Check logs...'
    end
  end

  def destroy
    unless Moderator.filter_by_employer_id(@moderator.employer_id).count > 1
      redirect_to admin_moderator_url(@moderator), notice: 'You can\'t delete employer\'s last moderator'
      return
    end
    if @moderator.destroy
      redirect_to admin_moderators_url, notice: 'Moderator deleted successfully'
    else
      redirect_to admin_moderator_url(@moderator), notice: 'Moderator deletion failed. Check logs...'
    end
  end

  protected

  def moderator_params
    params.require(:moderator).permit(
      :nickname,
      :employer_id,
      account_attributes: %i[
        email
        password
        password_confirmation
      ]
    )
  end
end
