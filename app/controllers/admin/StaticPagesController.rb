class Admin::StaticPagesController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404'
  }

  def show
    if STATIC_PAGES[params[:page].to_sym] != nil
      render "admin/static_pages/#{STATIC_PAGES[params[:page].to_sym]}"
    else
      render "admin/static_pages/#{STATIC_PAGES["not-found-404".to_sym]}"
    end
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
