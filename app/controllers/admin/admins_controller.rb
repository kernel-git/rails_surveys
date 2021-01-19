# frozen_string_literal: true

class Admin::AdminsController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @admins = Administrator.all.page(params[:page])
  end

  def show
    @admin = Administrator.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    log_exception(e)
    redirect_to(not_found_404_path)
  end

  def new
    @admin = Administrator.new
  end

  def create
    admin = Administrator.new({
                                nickname: params[:admin][:nickname]
                              })
    admin.build_account(
      account_type: 'administrator',
      email: params[:admin][:email],
      password: params[:admin][:password],
      password_confirmation: params[:admin][:password_confirmation]
    )
    admin.save!
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    log_exception(e)
    flash.alert = 'Administrator creation failed. Check logs...'
    redirect_to(admin_admins_url)
  else
    flash.notice = 'Administrator created successfully'
    redirect_to(admin_admin_url(@admin))
  end

  def edit
    Rails.logger.debug "Ping from admin/admins#edit with params: #{params}"
  end

  def update
    Rails.logger.debug "Ping from admin/admins#update with params: #{params}"
  end

  def destroy
    Rails.logger.debug "Ping from admin/admins#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
