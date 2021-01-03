class StaticPagesController < ApplicationController

  STATIC_PAGES = {
    'home': 'home',
    'faq': 'faq',
    'privacy-policy': 'privacy_policy',
    'contact-employer': 'contact_employer',
    'contact-support': 'contact_support',
    'not-found-404': 'not_found_404'
  }

  def show
    if STATIC_PAGES[params[:page].to_sym] != nil
      render "static_pages/#{STATIC_PAGES[params[:page].to_sym]}"
    else
      render "static_pages/#{STATIC_PAGES["not-found-404".to_sym]}"
    end
  end
end