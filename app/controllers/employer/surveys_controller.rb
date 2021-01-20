# frozen_string_literal: true

class Employer::SurveysController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @surveys = Survey.filter_by_employer_id(current_account.employer.id).page(params[:page])
  end

  def show
    id = params.require(:id)
    @survey = Survey.includes(:employer, question_groups: [questions: :options]).find(id)
    redirect_to(employer_static_pages_url(page: 'not-found-404')) if @survey.employer.id != current_account.employer.id
  rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing => e
    log_exception(e)
    redirect_to(employer_static_pages_url(page: 'not-found-404'))
  else
    @employees_data = []
    @current_assigned_employees_ids = []
    Employee.filter_by_employer_id(current_account.employer.id).each do |employee|
      unless SurveyEmployeeRelation.find_by(survey_id: id, employee_id: employee.id, is_conducted: true)
        @employees_data << [employee.id, employee.first_name, employee.last_name, employee.account.email]
      end
      employee.surveys.each do |survey|
        if survey.id == Integer(id) && !SurveyEmployeeRelation.find_by(
          survey_id: id, employee_id: employee.id).is_conducted
          @current_assigned_employees_ids << employee.id
        end
      end
    end
    @results = SurveyEmployeeRelation.where(survey_id: params[:id], is_conducted: true).includes(:employee)
  end

  def new
    @survey = Survey.new
    @employer = current_account.employer
  end

  def create
    begin
      @permitted_params = params.permit(
        survey: :label,
        question_groups: [
          :label,
          questions: [
            :question_type,
            options: [
              :label,
              :with_text_field
            ]
          ]
        ]
      )
    rescue ActionController::ParameterMissing => e
      log_exception(e)
      flash.alert 'Survey creation failed. Check logs...'
    else
      @survey = Survey.new(
        label: @permitted_params[:survey][:label]
      )
      @survey.employer = current_account.employer

      @permitted_params[:question_groups].each do |qgroup_params|
        @qgroup = QuestionGroup.new(label: qgroup_params[:label], survey: @survey)
        qgroup_params[:questions].each do |question_params|
          @question = Question.new(
            question_type: question_params[:question_type],
            benchmark_val: 1,
            benchmark_vol: 1,
            question_group: @qgroup
          )
          question_params[:options].each do |option_params|
            option = Option.new(text: option_params[:label], question: @question)
            option.has_text_field = option_params[:with_text_field] == 'on'
            @question.options << option
          end
          @qgroup.questions << @question
        end
        @survey.question_groups << @qgroup
      end
      begin
        @survey.save!
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
        log_exception(e)
        flash.alert = ('Survey creation failed. Check logs...')
        redirect_to(employer_surveys_url)
      else
        flash.notice('Survey created successfully')
        redirect_to(comapny_survey_url(@survey))
      end
    end
  end

  def edit
    Rails.logger.debug "Ping from employer/surveys#edit with params: #{params}"
  end

  def update
    begin
      @employees_ids = params.permit(:id, employees_ids: [])[:employees_ids]
      @employees_ids ||= []
      @id = params.require(:id)
      logger.debug @id
      logger.debug @employees_ids
    rescue ActionController::ParameterMissing => e
      log_exception(e)
      flash.alert 'Survey update failed. Check logs...'
    else
      begin
        @survey = Survey.includes(:employer, :employees, question_groups: [questions: :options]).find(Integer(params[:id]))
        redirect_to(not_found_404_path) if @survey.employer.id != current_account.employer.id
      rescue ActiveRecord::RecordNotFound => e
        redirect_to(not_found_404_path)
      else
        Employee.filter_conducted_by_survey_id(@survey.id).each do |employee|
          params[:employees_ids] << String(employee.id) unless params[:employees_ids].include?(String(employee.id))
        end
        if params[:employees_ids].nil?
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
  end

  def destroy
    Rails.logger.debug "Ping from employer/surveys#destroy with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end
