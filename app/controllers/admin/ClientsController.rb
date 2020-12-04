class Admin::ClientsController < ApplicationController
  layout 'admin'
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
    @client = Client.new({
      logo_url: params[:client][:logo_url],
      label: params[:client][:label],
      address: params[:client][:address],
      email: params[:client][:email],
      phone: params[:client][:phone]
    })
    @client.segments = Segment.where(id: params[:segments_ids])
    if @client.save
      redirect_to(admin_client_url(@client))
    else
      puts "Client save failed. Error message: #{@client.errors.full_messages}"
      redirect_to(admin_clients_url)
    end
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