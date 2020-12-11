class StaticPagesController < ApplicationController

  STATIC_PAGES = {
    'home': 'home',
    'faq': 'faq',
    'privacy-policy': 'privacy_policy',
    'contact-company': 'contact_company',
    'contact-support': 'contact_support',
    'not-found-404': 'not_found_404'
  }

  def show
    if STATIC_PAGES[params[:id]] != nil
      render "static_pages/#{STATIC_PAGES[params[:id].to_sym]}"
    else
      render "static_pages/#{STATIC_PAGES["not-found-404".to_sym]}"
    end
  end
  def home
    puts "Ping from static_pages#home"
  end
  def contact_company
    puts "Ping from static_pages#contact_company"
  end
  def contact_support
    puts "Ping from static_pages#contact_support"
  end
  def faq
    puts "Ping from static_pages#faq"
  end
  def privacy_policy
    puts "Ping from static_pages#privacy_policy"
  end
  def not_found_404
    puts "Ping from static_pages#not_found_404"
  end
end