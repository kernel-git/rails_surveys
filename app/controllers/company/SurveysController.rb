class Company::SurveysController < ApplicationController
  layout 'company'

  def index
    @surveys = []
    Survey.find_each do |survey|
      survey.clients.each do |client|
        if client.id == 1 # temporal constant id
          @surveys << survey
          break
        end
      end
    end
  end
  def show
    id = Integer(params[:id])
    begin
      @survey = Survey.includes(:clients, question_groups: [questions: [answers: [:user]]]).find(id)
      if @survey.clients.find(1) == nil # temporal constant id
        redirect_to(not_found_404_path)
      end
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    else
      @users_data = []
      @current_assigned_users_ids = []
      User.find_each do |user|
        if user.client.id == 1 # temporal constant id
          @users_data << [user.id, user.first_name, user.last_name, user.email]
          user.surveys.each do |survey|
            if survey.id == id
              @current_assigned_users_ids << user.id
            end
          end
        end
      end
      @survey_question_groups = @survey.question_groups
      p @current_assigned_users_ids  
    end
  end
  def new
    @survey = Survey.new
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
    @survey.clients << Client.find(1) # temporal constant id


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
      redirect_to company_surveys_url 
    else
      redirect_to comapny_survey_url(@survey)
    end
  end
  def edit
    puts "Ping from admin/surveys#edit with params: #{params}"
  end
  def update
    puts "Ping from admin/surveys#update with params: #{params}"
    id = Integer(params[:id])
    begin
      @survey = Survey.includes(:clients, :users, question_groups: [questions: [answers: [:user]]]).find(id)
      if @survey.clients.find(1) == nil # temporal constant id
        redirect_to(not_found_404_path)
      end
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    else
      #p params[:users_ids]
      @survey.user_ids = params[:users_ids]
    end
  end
  def destroy
    puts "Ping from admin/surveys#destroy with params: #{params}"
  end
end
