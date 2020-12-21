class Admin::StaticPagesController < ApplicationController
  layout 'admin'
  #before_action :authenticate_administrator!

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
end
