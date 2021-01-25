# frozen_string_literal: true

class Admin::StaticPagesController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404',
    'access-denied': 'access_denied'
  }.freeze

  def show
    if STATIC_PAGES[params[:page].to_sym].nil?
      render "admin/#{STATIC_PAGES['not-found-404'.to_sym]}"
    else
      render "admin/#{STATIC_PAGES[params[:page].to_sym]}"
    end
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_user_type == 'Administrator'
  end
end
