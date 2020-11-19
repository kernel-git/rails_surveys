class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    id = Integer(params[:id])
    begin
      @user = User.includes(:segments, :client, answers: [question: [question_group: [:survey]]]).find(id)
    rescue ActiveRecord::RecordNotFound => e
      redirect_to(not_found_404_path)
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
    puts "Ping from admin/users#create with params: #{params}"
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