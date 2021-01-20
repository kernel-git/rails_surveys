# frozen_string_literal: true

class StaticPagesController < ApplicationController
  STATIC_PAGES = {
    'home': 'home',
    'faq': 'faq',
    'privacy-policy': 'privacy_policy',
    'contact-employer': 'contact_employer',
    'contact-support': 'contact_support',
    'not-found-404': 'not_found_404'
  }.freeze

  def show
    page = params.require(:page)
    rescue ActionController::ParameterMissing => e
      log_exception(e)
      render "/#{STATIC_PAGES['not-found-404'.to_sym]}"
    else
      if STATIC_PAGES[params[:page].to_sym].nil?
        render "#{STATIC_PAGES['not-found-404'.to_sym]}"
      else
        render "#{STATIC_PAGES[params[:page].to_sym]}"
      end
  end
end
