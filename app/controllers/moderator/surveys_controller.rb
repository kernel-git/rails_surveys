# frozen_string_literal: true

class Moderator::SurveysController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :search

  def index
    @surveys = @surveys.page(params[:page])
  end

  def show
    @employees_data = []
    @current_assigned_employees_ids = []
    @employees_data = Employee.filter_by_employer_id(@survey.employer.id).collect do |employee|
      unless SurveyEmployeeConnection.where(survey: @survey, employee: employee, is_conducted: true).present?
        [employee.id, employee.first_name, employee.last_name,
         employee.account.email, employee.employer.label]
      end
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
  end

  def destroy
    if @survey.destroy
      redirect_to moderator_surveys_url, notice: 'Survey deleted successfully'
    else
      redirect_to moderator_survey_url(@survey), notice: 'Survey deletion failed. Check logs...'
    end
  end

  def search
    if params[:search].blank?
      redirect_to moderator_surveys_url, alert: 'Search field empty'
    else
      @search_results = SearchRecordsQuery.new({
          columns: [:label],
          search_text: params[:search]
        },
        Survey.filter_by_employer_id(current_account.account_user.employer.id)
      ).all.page(params[:page])
    end
  end

  def statistic
    if @survey.present?
      @survey_statistic = @survey.survey_statistic
      render 'statistic'
    else
      @statistic_data = {
        month: { assigned: 0, conducted: 0 },
        week: { assigned: 0, conducted: 0 },
        day: { assigned: 0, conducted: 0 },
        hour: { assigned: 0, conducted: 0 }
      }
      SurveyStatistic.find_each do |survey_stat|
        @statistic_data[:month][:assigned] += survey_stat.month_assigned
        @statistic_data[:month][:conducted] += survey_stat.month_conducted
        @statistic_data[:week][:assigned] += survey_stat.week_assigned
        @statistic_data[:week][:conducted] += survey_stat.week_conducted
        @statistic_data[:day][:assigned] += survey_stat.day_assigned
        @statistic_data[:day][:conducted] += survey_stat.day_conducted
        @statistic_data[:hour][:assigned] += survey_stat.hour_assigned
        @statistic_data[:hour][:conducted] += survey_stat.hour_conducted
      end
      render 'statistic_all'
    end
  end

  protected

  def survey_params
    params[:survey][:employer_id] = current_account.account_user_id
    params[:survey][:survey_statistic_attributes] = {}
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
