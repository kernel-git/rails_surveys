class Account::StaticPagesController < ApplicationController
  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404'
  }.freeze

  def show
    if !STATIC_PAGES[params[:page].to_sym].nil?
      render "account/static_pages/#{STATIC_PAGES[params[:page].to_sym]}"
    else
      render "account/static_pages/#{STATIC_PAGES['not-found-404'.to_sym]}"
    end
  end
end
