class Admin::StaticPagesController < ApplicationController
  layout 'admin'
  before_action :authenticate_administrator!

  def home
    puts "Ping from admin/static_pages#home"
  end
end