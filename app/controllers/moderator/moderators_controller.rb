# frozen_string_literal: true

class Moderator::ModeratorsController < ApplicationController
  load_and_authorize_resource

  def index
    @moderators = @moderators.page(params[:page])
  end

  def show; end

  def new; end

  def create
    if @moderator.save
      redirect_to moderator_moderator_url(@moderator), notice: 'Moderator created successfully'
    else
      log_errors(@moderator)
      redirect_to new_moderator_moderator_url, alert: 'Moderator creation failed. Check logs...'
    end
  end

  def edit; end

  def update
    if @moderator.update(moderator_params)
      redirect_to moderator_moderator_url(@moderator), notice: 'Moderator updated successfully'
    else
      log_errors(@moderator)
      redirect_to edit_moderator_moderator_url(@moderator), alert: 'Moderator update failed. Check logs...'
    end
  end

  def destroy
    if current_account.account_user == @moderator
      redirect_to moderator_moderator_url(@moderator), notice: 'You can\'t delete yourself.'
      return
    end

    if @moderator.destroy
      redirect_to moderator_moderators_url, notice: 'Moderator deleted successfully'
    else
      redirect_to moderator_moderator_url(@moderator), notice: 'Moderator deletion failed. Check logs...'
    end
  end

  protected

  def moderator_params
    params.require(:moderator).permit(
      :nickname,
      account_attributes: %i[
        email
        password
      ]
    )
  end
end
