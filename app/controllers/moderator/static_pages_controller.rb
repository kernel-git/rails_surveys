# frozen_string_literal: true

class Moderator::StaticPagesController < ApplicationController
  before_action :check_account_type, if: :authenticate_account!

  STATIC_PAGES = {
    'home': 'home'
  }.freeze

  def show
    if STATIC_PAGES[params[:page].to_sym].nil?
      redirect_to static_pages_url(page: 'not-found-404')
    else
      render "moderator/#{STATIC_PAGES[params[:page].to_sym]}"
    end
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_user_type == 'Moderator'
  end
end
