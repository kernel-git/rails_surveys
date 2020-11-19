class Admin::SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end
  def show
    id = Integer(params[:id])
    begin
      @survey = Survey.includes(:clients, question_groups: [questions: [answers: [:user]]]).find(id)
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    else
      @survey_clients = @survey.clients
      @survey_question_groups = @survey.question_groups      
    end
  end
  def new
    @survey = Survey.new
    @clients_data = Client.all.collect { |client| [client.id, client.label] }
  end
  def create
    puts "Ping from admin/surveys#create"
  end
  def edit
    puts "Ping from admin/surveys#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/surveys#update with params: #{params}"
  end
  def destroy
    puts "Ping from admin/surveys#destroy with params: #{params}"
  end
end
