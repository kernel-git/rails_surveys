# frozen_string_literal: true

class Employer::SurveysController < ApplicationController
  layout 'employer'
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @surveys = @surveys.page(params[:page])
  end

  def show
    @survey = Survey.includes(:employer, question_groups: [questions: :options]).find(params[:id])
    @employees_data = []
    @current_assigned_employees_ids = []
    @employees_data = Employee.filter_by_employer_id(@survey.employer.id).collect do |employee|
      [employee.id, employee.first_name, employee.last_name,
       employee.account.email, employee.employer.label]
    end
    Employee.filter_by_employer_id(@survey.employer.id).filter_avaible_by_survey_id(@survey.id).collect do |employee|
      @current_assigned_employees_ids << employee.id
    end
    @results = SurveyEmployeeRelation.where(survey_id: params[:id], is_conducted: true).includes(:employee)
  end

  def new; end

  def create
    question_group_params[:question_groups].each do |qgroup_params|
      @qgroup = @survey.question_groups.build(label: qgroup_params[:label])
      qgroup_params[:questions].each do |question_params|
        @question = @qgroup.questions.build(
          question_type: question_params[:question_type],
          benchmark_val: 1,
          benchmark_vol: 1
        )
        question_params[:options].each do |option_params|
          @question.options.build(
            text: option_params[:label],
            has_text_field: option_params[:with_text_field] == 'on'
          )
        end
      end
    end

    if @survey.save
      redirect_to employer_survey_url(@survey), notice: 'Survey created successfully'
    else
      log_errors(@survey)
      redirect_to employer_surveys_url, alert: 'Survey creation failed. Check logs...'
    end
  end

  def edit
    Rails.logger.debug "Ping from employer/surveys#edit with params: #{params}"
  end

  def update
    Employee.filter_conducted_by_survey_id(@survey.id).each do |employee|
      params[:employees_ids] << String(employee.id) unless params[:employees_ids].include?(String(employee.id))
    end
    @survey.employee_ids = params[:employees_ids]
    if @survey.save
      redirect_to employer_survey_url(@survey), notice: 'Survey updated successfully'
    else
      log_errors(@survey)
      redirect_to employer_survey_url(@survey), alert: 'Survey update failed. Check logs...'
    end

    #   @employees_ids = params.permit(:id, employees_ids: [])[:employees_ids]
    #   @employees_ids ||= []
    #   @id = params.require(:id)
    #   logger.debug @id
    #   logger.debug @employees_ids
    # rescue ActionController::ParameterMissing => e
    #   log_exception(e)
    #   flash.alert 'Survey update failed. Check logs...'
    # else
    #   begin
    #     @survey = Survey.includes(:employer, :employees, question_groups: [questions: :options]).find(Integer(params[:id]))
    #     redirect_to(not_found_404_path) if @survey.employer.id != current_account.employer.id
    #   rescue ActiveRecord::RecordNotFound => e
    #     redirect_to(not_found_404_path)
    #   else
    #     Employee.filter_conducted_by_survey_id(@survey.id).each do |employee|
    #       params[:employees_ids] << String(employee.id) unless params[:employees_ids].include?(String(employee.id))
    #     end
    #     if params[:employees_ids].nil?
    #       @survey.employees.clear
    #       return
    #     end
    #     @survey.employee_ids = params[:employees_ids]
    #     params[:employees_ids].each do |employee_id|
    #       relation = SurveyEmployeeRelation.where(survey_id: @survey.id, employee_id: employee_id).first
    #       relation.is_conducted = false if relation.is_conducted != true
    #       relation.save
    #     end
    #   end
  end

  def destroy
    Rails.logger.debug "Ping from employer/surveys#destroy with params: #{params}"
  end

  protected

  def survey_params
    params.require(:survey).permit(:label)
  end

  def question_group_params
    params.permit(
      question_groups: [
        :label,
        { questions: [
          :question_type,
          { options: %i[
            label
            with_text_field
          ] }
        ] }
      ]
    )
  end
end
