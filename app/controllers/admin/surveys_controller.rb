# frozen_string_literal: true

class Admin::SurveysController < ApplicationController
  layout 'admin'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @surveys = Survey.all.page(params[:page])
  end

  def show
      id = params.require(:id)
      @survey = Survey.includes(:employer, question_groups: [questions: :options]).find(id)
    rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing => e
      log_exception(e)
      redirect_to(admin_static_pages_url(page: 'not-found-404'))
    else
      @employees_data = []
      @employees = []
      @current_assigned_employees_ids = []
      Employee.filter_by_employer_id(@survey.employer.id).each do |employee|
        unless SurveyEmployeeRelation.find_by(survey_id: params[:id], employee_id: employee.id, is_conducted: true)
          @employees_data << [
            employee.id,
            employee.first_name,
            employee.last_name,
            employee.account.email,
            employee.employer.label
          ]
        end
        employee.surveys.each do |survey|
          if survey.id == Integer(params[:id]) && !SurveyEmployeeRelation.find_by(survey_id: params[:id], employee_id: employee.id).is_conducted
            @current_assigned_employees_ids << employee.id
          end
        end
      end
      @results = SurveyEmployeeRelation.where(survey_id: params[:id], is_conducted: true).includes(:employee)
  end

  def new
    @survey = Survey.new
    @employers = Employer.all
  end

  def create
    begin
      @permitted_params = params.permit(
        :employer_id,
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
      @survey.employer = Employer.find(@permitted_params[:employer_id])

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
        flash.alert = 'Survey creation failed. Check logs...'
        redirect_to(employer_surveys_url)
      else
        flash.notice = 'Survey created successfully'
        redirect_to(comapny_survey_url(@survey))
      end
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
