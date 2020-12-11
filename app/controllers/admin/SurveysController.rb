class Admin::SurveysController < ApplicationController
  layout 'admin'
  before_action :authenticate_administrator!

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
    @clients_data = Client.all.collect { |client| [client.id, client.logo_url, client.label, client.email] }
  end
  def create
    if params[:survey] == nil || params[:question_groups] == nil
      return
    end
    @survey = Survey.new(
      label: params[:survey][:label]
    )

    @qgroups = Array.new
    @questions = Array.new
    unless @survey.valid?
      puts "Survey is not valid. Error messages:"
      @survey.errors.full_messages.each { |e| puts e}
      return
    end
    @survey.clients << Client.find(params[:client_id])


    params[:question_groups].each do |qgroup_params|
      @qgroup = QuestionGroup.new(label: qgroup_params[:question_group][:label])

      qgroup_params[:question_group][:questions].each do |question_params|
        @question = Question.new(
          question_type: question_params[:question][:question_type],
          benchmark_val: 1,
          benchmark_vol: 1
        )
        @question.question_group = @qgroup
        unless @question.valid?
          puts "Question is not valid. Error messages:"
          @question.errors.full_messages.each { |e| puts e}
          return
        end
        @questions << @question
      end
      @qgroup.survey = @survey

      unless @qgroup.valid?
        puts "Question group is not valid. Error messages:"
        @qgroup.errors.full_messages.each { |e| puts e}
        return
      end
      @qgroups << @qgroup
    end
    begin 
      puts 'Survey save started'
      @survey.save!
      @qgroups.each { |e| e.save! }
      @questions.each { |e| e.save! }
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      puts "Survey save failed. Exception type: #{e.class.name}, exception message: #{e.message}"
      redirect_to admin_surveys_url 
    else
      redirect_to admin_survey_url(@survey)
    end
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
