# frozen_string_literal: true

class Employee::StaticPagesController < ApplicationController
  # layout 'employee'
  before_action :check_account_type, if: :authenticate_account!

  STATIC_PAGES = {
    'home': 'home'
  }.freeze

  def show
    if STATIC_PAGES[params[:page].to_sym].nil?
      redirect_to static_pages_url(page: 'not-found-404')
    else
      render "employee/#{STATIC_PAGES[params[:page].to_sym]}"
    end
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_user_type == 'Employee'
  end
end
