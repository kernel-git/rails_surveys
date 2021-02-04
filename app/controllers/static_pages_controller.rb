# frozen_string_literal: true

class StaticPagesController < ApplicationController
  STATIC_PAGES = {
    'home': 'home',
    'faq': 'faq',
    'privacy-policy': 'privacy_policy',
    'contact-employer': 'contact_employer',
    'contact-support': 'contact_support',
    'not-found-404': 'not_found_404',
    'access-denied': 'access_denied',
    'request-invalid': 'request_invalid'
  }.freeze

  def show
    if STATIC_PAGES[params[:page].to_sym].nil?
      render (STATIC_PAGES['not-found-404'.to_sym]).to_s
    else
      render (STATIC_PAGES[params[:page].to_sym]).to_s
    end
  end
end
