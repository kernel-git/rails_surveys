class Admin::StatsController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  STATS_PAGES {
    'stats': 'stats',
    'stats-live': 'stats_live',
    'stats-historical': 'stats_historical',
  }

  def show
    @employer = employer.find(params[:employer_id])
    if STATS_PAGES[params[:stats_id].to_sym] != nil
      render "stats_pages/#{STATS_PAGES[params[:stats_id].to_sym]}"
    else
      redirect_to 'static_pages/home'
    end  
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end