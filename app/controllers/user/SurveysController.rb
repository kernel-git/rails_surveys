class User::SurveysController < ApplicationController
  def index
    puts "Ping from user/surveys#index"
  end
  def show
    puts "Ping from admin/surveys#show with params: #{params}"
  end
  def edit
    puts "Ping from admin/surveys#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/surveys#update with params: #{params}"
  end
end
