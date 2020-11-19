class Company::ClientsController < ApplicationController
  def show
    puts "Ping from company/clients#show with params: #{params}"
  end
  def edit
    puts "Ping from company/clients#edit with params: #{params}"
  end
  def update
    puts "Ping from company/clients#update with params: #{params}"
  end
  def stats
    puts "Ping from company/clients#stats"
  end
  def live
    puts "Ping from company/clients#live"
  end
  def historical
    puts "Ping from company/clients#historical"
  end
end