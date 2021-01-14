class Employee::StaticPagesController < ApplicationController
  layout 'employee'
  before_action :check_account_type, if: :authenticate_account!

  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404'
  }.freeze

  def show
    if !STATIC_PAGES[params[:page].to_sym].nil?
      render "employee/static_pages/#{STATIC_PAGES[params[:page].to_sym]}"
    else
      render "employee/static_pages/#{STATIC_PAGES['not-found-404'.to_sym]}"
    end
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'employee'
  end
end
