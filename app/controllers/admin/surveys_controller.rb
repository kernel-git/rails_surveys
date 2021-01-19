# frozen_string_literal: true

class Admin::SurveysController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @surveys = Survey.all.page(params[:page])
  end

  def show
    @survey = Survey.includes(:employer, question_groups: [questions: :options]).find(Integer(params[:id]))
  rescue ActiveRecord::RecordNotFound => e
    log_exception(e)
    render('admin/static_pages/not_found_404')
  else
    Rails.logger.info('Survey found!')
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
  end

  def new
    @survey = Survey.new
    @employers_data = Employer.all.collect { |employer| [employer.id, employer.logo_url, employer.label, employer.public_email] }
  end

  def create
    return true if params[:survey].nil? || params[:question_groups].nil?

    @survey = Survey.new(
      label: params[:survey][:label]
    )

    @qgroups = []
    @questions = []
    @options = []

    @survey.employer = Employer.find(params[:employer_id])

    unless @survey.valid?
      Rails.logger.error 'Survey is not valid. Error messages:'
      @survey.errors.full_messages.each { |e| Rails.logger.error e }
      return true
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
          @option.has_text_field = option_params[:with_text_field] == 'on'
          @option.question = @question
          unless @option.valid?
            Rails.logger.error 'Option is not valid. Error messages:'
            @option.errors.full_messages.each { |e| Rails.logger.error e }
            return true
          end
          @options << @option
        end
        unless @question.valid?
          Rails.logger.error 'Question is not valid. Error messages:'
          @question.errors.full_messages.each { |e| Rails.logger.error e }
          return true
        end
        @questions << @question
      end
      @qgroup.survey = @survey

      unless @qgroup.valid?
        Rails.logger.error 'Question group is not valid. Error messages:'
        @qgroup.errors.full_messages.each { |e| Rails.logger.error e }
        return true
      end
      @qgroups << @qgroup
    end
    begin
      @survey.save!
      @qgroups.each(&:save!)
      @questions.each(&:save!)
      @options.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
      flash.alert = 'Survey creation failed. Check logs...'
      redirect_to admin_surveys_url
    else
      flash.notice = 'Survey created successfully'
      redirect_to admin_survey_url(@survey)
    end
  end

  def edit
    Rails.logger.debug "Ping from admin/surveys#edit with params: #{params}"
  end

  def update
    Rails.logger.debug "Ping from admin/surveys#update with params: #{params}"
  end

  def destroy
    Rails.logger.debug "Ping from admin/surveys#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'administrator'
  end
end
