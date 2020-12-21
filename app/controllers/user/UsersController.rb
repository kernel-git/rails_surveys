class User::UsersController < ApplicationController
  layout 'user'
  
  def show
    puts "Ping from user/users#show with params: #{params}"
  end
  def edit
    puts "Ping from user/users#edit with params: #{params}"
  end
  def update
    puts "Ping from user/users#update with params: #{params}"
  end
end
