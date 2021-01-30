# frozen_string_literal: true

class Account::StaticPagesController < ApplicationController
  STATIC_PAGES = {
    'home': 'home'
  }.freeze

  def show
    if STATIC_PAGES[params[:page].to_sym].nil?
      redirect_to static_pages_url(page: 'not-found-404')
    else
      render "account/static_pages/#{STATIC_PAGES[params[:page].to_sym]}"
    end
  end
end
