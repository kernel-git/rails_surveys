class Admin::SurveysController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @surveys = Survey.all.page(params[:page])
  end
  def show
    puts "params[:id]: #{params[:id]}"
    begin
      @survey = Survey.includes(:employer, question_groups: [questions: :options]).find(params[:id])
    rescue ActiveRecord::RecordNotFound => e 
      render("admin/static_pages/not_found_404")
    else
      @employees_data = []
      @current_assigned_employees_ids = []
      Employee.filter_by_employer_id(@survey.employer.id).each do |employee|
        unless SurveyEmployeeRelation.find_by(survey_id: params[:id], employee_id: employee.id, is_conducted: true)
          @employees_data << [employee.id, employee.first_name, employee.last_name, employee.account.email]
        end
        employee.surveys.each do |survey|
          if survey.id == Integer(params[:id]) && !SurveyEmployeeRelation.find_by(survey_id: params[:id], employee_id: employee.id).is_conducted
            @current_assigned_employees_ids << employee.id
          end
        end
      end
      @results = SurveyEmployeeRelation.where(survey_id: params[:id], is_conducted: true).includes(:employee)
      @survey_question_groups = @survey.question_groups
      p @current_assigned_employees_ids  
    end
  end
  def new
    @survey = Survey.new
    @employers_data = Employer.all.collect { |employer| [employer.id, employer.logo_url, employer.label, employer.public_email] }
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
    @options = Array.new

    @survey.employer = Employer.find(params[:employer_id])

    unless @survey.valid?
      puts "Survey is not valid. Error messages:"
      @survey.errors.full_messages.each { |e| puts e}
      return
    end 

    params[:question_groups].each do |qgroup_params|
      @qgroup = QuestionGroup.new(label: qgroup_params[:label])

      qgroup_params[:questions].each do |question_params|
        @question = Question.new(
          question_type: question_params[:question_type],
          benchmark_val: 1,
          benchmark_vol: 1
        )
        @question.question_group = @qgroup
        question_params[:options].each do |option_params|
          @option = Option.new(text: option_params[:label])
          @option.has_text_field = option_params[:with_text_field] == 'on' ? true: false
          @option.question = @question
          unless @option.valid?
            puts "Option is not valid. Error messages:"
            @option.errors.full_messages.each { |e| puts e}
            return
          end
          @options << @option
        end
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
      @options.each { |e| e.save! }
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

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
