# frozen_string_literal: true

class Moderator::SurveysController < ApplicationController
  load_and_authorize_resource

  def index
    @surveys = @surveys.page(params[:page])
  end

  def show
    @employees_data = []
    @current_assigned_employees_ids = []
    @employees_data = Employee.filter_by_employer_id(@survey.employer.id).collect do |employee|
      [employee.id, employee.first_name, employee.last_name,
       employee.account.email, employee.employer.label]
    end
    Employee.filter_by_employer_id(@survey.employer.id).filter_avaible_by_survey_id(@survey.id).collect do |employee|
      @current_assigned_employees_ids << employee.id
    end
    @results = SurveyEmployeeConnection.where(survey_id: params[:id], is_conducted: true).includes(:employee)
  end

  def new; end

  def create
    if @survey.save
      redirect_to moderator_survey_url(@survey), notice: 'Survey created successfully'
    else
      log_errors(@survey)
      redirect_to moderator_surveys_url, alert: 'Survey creation failed. Check logs...'
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
      redirect_to moderator_survey_url(@survey), notice: 'Survey updated successfully'
    else
      log_errors(@survey)
      redirect_to moderator_survey_url(@survey), alert: 'Survey update failed. Check logs...'
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
    #       connection = SurveyEmployeeConnection.where(survey_id: @survey.id, employee_id: employee_id).first
    #       connection.is_conducted = false if connection.is_conducted != true
    #       connection.save
    #     end
    #   end
  end

  def destroy
    Rails.logger.debug "Ping from employer/surveys#destroy with params: #{params}"
  end

  protected

  def survey_params
    params[:survey][:employer_id] = current_account.account_user_id
    params.require(:survey).permit(
      :label,
      :employer_id,
      question_groups_attributes: [
        :label,
        { questions_attributes: [
          :question_type,
          :benchmark_val,
          :benchmark_vol,
          { options_attributes: %i[
            text
            has_text_field
          ] }
        ] }
      ]
    )
  end
end
