class Employer::StaticPagesController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404'
  }

  def show
    if STATIC_PAGES[params[:id]] != nil
      render "employer/static_pages/#{STATIC_PAGES[params[:id].to_sym]}"
    else
      render "employer/static_pages/#{STATIC_PAGES["not-found-404".to_sym]}"
    end
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end