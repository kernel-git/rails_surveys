class Admin::AdminsController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

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
      nickname: params[:admin][:nickname]
    })
    @account = Account.new({
      account_type: 'administrator',
      email: params[:admin][:email],
      password: params[:admin][:password],
      password_confirmation: params[:admin][:password_confirmation]
    })
    if @admin.valid? && @account.valid?
      begin
        @account.save!
        @admin.account = @account
        @admin.save!
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
        puts '--->EXEPTION DURING Admin/Account SAVE<---'
        puts "Exeption type: #{e.class.name}"
        puts "Exeption message: #{e.message}"
        puts '~~~~~~~Stack trace~~~~~~~'
        e.backtrace.each { |line| puts line }
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
        redirect_to(admin_admins_url)
      else
        redirect_to(admin_admin_url(@admin))
      end
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

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end