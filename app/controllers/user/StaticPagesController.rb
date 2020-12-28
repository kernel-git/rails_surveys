class User::StaticPagesController < ApplicationController
  layout 'user'
  before_action :authenticate_user!

  STATIC_PAGES = {
    'home': 'home',
    'not-found-404': 'not_found_404'
  }

  def show
    if STATIC_PAGES[params[:page].to_sym] != nil
      render "user/static_pages/#{STATIC_PAGES[params[:page].to_sym]}"
    else
      render "user/static_pages/#{STATIC_PAGES["not-found-404".to_sym]}"
    end
  end
end
