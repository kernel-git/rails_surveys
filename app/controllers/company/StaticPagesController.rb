class Company::StaticPagesController < ApplicationController
  layout 'company'

  def home
    puts "Ping from company/static_pages#home"
  end
end