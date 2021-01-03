class Employer::SurveysController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @surveys = Survey.filter_by_employer_id(current_account.employer.id).page(params[:page])
  end
  def show
    puts "params[:id]: #{params[:id]}"
    begin
      @survey = Survey.includes(:employer, question_groups: [questions: :options]).find(params[:id])
      if @survey.employer.id != current_account.employer.id
        render("employer/static_pages/not_found_404")
      end
    rescue ActiveRecord::RecordNotFound => e 
      render("employer/static_pages/not_found_404")
    else
      @employees_data = []
      @current_assigned_employees_ids = []
      Employee.filter_by_employer_id(current_account.employer.id).each do |employee|
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
    @employer = current_account.employer
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
    @survey.employer << current_account.employer


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
      redirect_to employer_surveys_url 
    else
      redirect_to comapny_survey_url(@survey)
    end
  end
  def edit
    puts "Ping from employer/surveys#edit with params: #{params}"
  end
  def update
    puts "Ping from employer/surveys#update with params: #{params}"
    id = Integer(params[:id])
    begin
      @survey = Survey.includes(:employer, :employees, question_groups: [questions: :options]).find(id)
      if @survey.employer.id != current_account.employer.id
        redirect_to(not_found_404_path)
      end
    rescue ActiveRecord::RecordNotFound => e 
      redirect_to(not_found_404_path)
    else
      Employee.filter_conducted_by_survey_id(@survey.id).each do |employee|
        params[:employees_ids] << String(employee.id) unless params[:employees_ids].include?(String(employee.id))
      end
      if params[:employees_ids] == nil
        @survey.employees.clear
        return
      end
      @survey.employee_ids = params[:employees_ids]
      params[:employees_ids].each do |employee_id|
        relation = SurveyEmployeeRelation.where(survey_id: @survey.id, employee_id: employee_id).first
        relation.is_conducted = false if relation.is_conducted != true
        relation.save
      end
    end
  end
  def destroy
    puts "Ping from employer/surveys#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end
