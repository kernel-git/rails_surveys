class Company::StaticPagesController < ApplicationController
  layout 'company'

  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404'
  }

  def show
    if STATIC_PAGES[params[:id]] != nil
      render "company/static_pages/#{STATIC_PAGES[params[:id].to_sym]}"
    else
      render "company/static_pages/#{STATIC_PAGES["not-found-404".to_sym]}"
    end
  end
end