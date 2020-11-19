class Admin::ClientsController < ApplicationController
  def index
    @clients = Client.all
  end
  def show
    id = Integer(params[:id])
    begin
      @client = Client.find(id)
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    else
      @clients_users = @client.users
      @clients_segments = @client.segments
    end
  end
  def new
    @client = Client.new
    @segments_data = Segment.all.collect { |segment| [segment.id, segment.label] }
  end
  def create
    puts "Ping from admin/clients#create with params: #{params}"
  end
  def edit
    puts "Ping from admin/clients#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/clients#update with params: #{params}"
  end
  def destroy
    puts "Ping from admin/clients#destroy with params: #{params}"
  end 
  def stats
    puts "Ping from admin/clients#stats"
  end
  def live
    puts "Ping from admin/clients#live"
  end
  def historical
    puts "Ping from admin/clients#historical"
  end
end