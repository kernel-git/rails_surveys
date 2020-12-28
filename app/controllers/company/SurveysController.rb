class Company::SurveysController < ApplicationController
  layout 'company'
  before_action :authenticate_client!

  def index
    @surveys = Survey.filter_by_client_id(current_client.id).page(params[:page])
  end
  def show
    puts "params[:id]: #{params[:id]}"
    begin
      @survey = Survey.includes(:client, question_groups: [questions: [answers: [:user]]]).find(params[:id])
      if @survey.client.id != current_client.id
        render("company/static_pages/not_found_404")
      end
    rescue ActiveRecord::RecordNotFound => e 
      render("company/static_pages/not_found_404")
    else
      @users_data = []
      @current_assigned_users_ids = []
      User.filter_by_client_id(current_client.id).each do |user|
        unless SurveyUserRelation.find_by(survey_id: params[:id], user_id: user.id, is_conducted: true)
          @users_data << [user.id, user.first_name, user.last_name, user.email]
        end
        user.surveys.each do |survey|
          if survey.id == Integer(params[:id]) && !SurveyUserRelation.find_by(survey_id: params[:id], user_id: user.id).is_conducted
            @current_assigned_users_ids << user.id
          end
        end
      end
      @conducted_users = User.filter_conducted_by_survey_id(params[:id])
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
    @survey.clients << Client.find(current_client.id)


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
    puts "Ping from company/surveys#edit with params: #{params}"
  end
  def update
    puts "Ping from company/surveys#update with params: #{params}"
    id = Integer(params[:id])
    begin
      @survey = Survey.includes(:client, :users, question_groups: [questions: [answers: [:user]]]).find(id)
      if @survey.client.id != current_client.id
        redirect_to(not_found_404_path)
      end
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    else
      User.filter_conducted_by_survey_id(@survey.id).each do |user|
        params[:users_ids] << String(user.id) unless params[:users_ids].include?(String(user.id))
      end
      if params[:users_ids] == nil
        @survey.users.clear
        return
      end
      @survey.user_ids = params[:users_ids]
      params[:users_ids].each do |user_id|
        relation = SurveyUserRelation.where(survey_id: @survey.id, user_id: user_id).first
        relation.is_conducted = false if relation.is_conducted != true
        relation.save
      end
    end
  end
  def destroy
    puts "Ping from company/surveys#destroy with params: #{params}"
  end
end
