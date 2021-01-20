# frozen_string_literal: true

class Employer::StaticPagesController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404'
  }.freeze

  def show
      page = params.require(:page)
    rescue ActionController::ParameterMissing => e
      log_exception(e)
      render "employer/#{STATIC_PAGES['not-found-404'.to_sym]}"
    else
      if STATIC_PAGES[page.to_sym].nil?
        render "employer/#{STATIC_PAGES['not-found-404'.to_sym]}"
      else
        render "employer/#{STATIC_PAGES[page.to_sym]}"
      end
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end
