class Admin::AdminsController < ApplicationController
  layout 'admin'
  #before_action :authenticate_administrator!

  def index
    @admins = Administrator.all.page(params[:page])
  end
  def show
    id = Integer(params[:id])
    begin
      @admin = Administrator.find(id)
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    end
  end
  def new
    @admin = Administrator.new
  end
  def create
    @admin = Administrator.new({
      nickname: params[:admin][:nickname],
      email: params[:admin][:email],
      password: params[:admin][:password],
      password_confirmation: params[:admin][:password_confirmation]
    })
    if @admin.save
      redirect_to(admin_admin_url(@admin))
    else
      puts "Admin save failed. Error message: #{@admin.errors.full_messages}"
      redirect_to(admin_admins_url)
    end
  end
  def edit
    puts "Ping from admin/admins#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/admins#update with params: #{params}"
  end
  def destroy
    puts "Ping from admin/admins#destroy with params: #{params}"
  end 
end