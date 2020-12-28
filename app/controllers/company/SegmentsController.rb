class Company::SegmentsController < ApplicationController
  layout 'company'
  before_action :authenticate_client!

  def index
    @segments = Segment.all.page(params[:page])
  end
  def show
    id = Integer(params[:id])
    begin
      @segment = Segment.find(id)
    rescue ActiveRecord::RecordNotFound => e 
      render("company/static_pages/not_found_404")
    else
      @segment_users = @segment.users      
    end
  end
  def new
    @segment = Segment.new
    @users_data = User.all.collect { |user| [user.id, user.first_name, user.last_name, user.email, user.client.label] }
    @clients_data = Client.all.collect { |client| [client.id, client.logo_url, client.label, client.email] }
  end
  def create
    @segment = Segment.new({
      label: params[:segment][:label]
    })
    @segment.clients << Client.find(current_client.id)
    @segment.users = User.where(id: params[:users_ids])
    if @segment.save
      redirect_to(company_segment_url(@segment))
    else
      puts "Segment save failed. Error message: #{@segment.errors.full_messages}"
      redirect_to(company_segments_url)
    end
  end
  def edit
    puts "Ping from admin/segments#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/segments#update with params: #{params}"
  end
  def destroy
    puts "Ping from admin/segments#destroy with params: #{params}"
  end
end