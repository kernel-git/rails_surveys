class Company::UsersController < ApplicationController
  layout 'company'
  before_action :authenticate_client!

  def index
    @users = User.filter_by_client_id(current_client.id).page(params[:page])
  end

  def show
    id = params[:id]
    begin
      @user = User.includes(:segments, :client, answers: [question: [question_group: [:survey]]]).find(id)
      if @user.client.id != current_client.id
        render("company/static_pages/not_found_404")
      end
    rescue ActiveRecord::RecordNotFound => e
      render("company/static_pages/not_found_404")
    else
      @user_client = @user.client
      @user_segments = @user.segments
      @user_answers = @user.answers
    end
  end

  def new
    @user = User.new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
  end

  def create
    @user = User.new({
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      email: params[:user][:email],
      account_type: params[:user][:account_type],
      password: params[:user][:password],
      age: params[:user][:age],
      position_age: params[:user][:position_age],
      opt_out: params[:user][:opt_out]
    })
    @user.client = Client.find(current_client.id)
    @user.segments = Segment.where(id: params[:segments_ids])
    if @user.save
      redirect_to(company_user_url(@user))
    else
      puts "User save failed. Error message: #{@user.errors.full_messages}"
      redirect_to(company_users_url)
    end
  end

  def edit
    puts "Ping from admin/users#edit with params: #{params}"
  end

  def update
    puts "Ping from admin/users#update with params: #{params}"
  end

  def destroy
    puts "Ping from admin/users#destroy with params: #{params}"
  end
end