# frozen_string_literal: true

class Admin::SurveysController < ApplicationController
  load_and_authorize_resource

  def index
    @surveys = @surveys.page(params[:page])
  end

  def show
    @conducted_percents = if SurveyEmployeeConnection.filter_by_survey_id(@survey.id).count.positive?
                            (SurveyEmployeeConnection.filter_by_survey_id(@survey.id).filter_conducted.count
                                                    .fdiv(SurveyEmployeeConnection.filter_by_survey_id(@survey.id)
                                                      .count) * 100).round(2)
                          else
                            '?'
                          end
    @option_stats_data = {}
    @survey.question_groups.each do |qgroup|
      qgroup.questions.each do |question|
        answers_for_this_question = 0
        question.options.each { |option| answers_for_this_question += option.answers.count }
        question.options.each do |option|
          @option_stats_data[option.id.to_s.to_sym] = if answers_for_this_question.zero?
                                                        '?'
                                                      else
                                                        (Answer.where(option: option).count.fdiv(
                                                          answers_for_this_question) * 100).round(2)
                                                      end
        end
      end
    end
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
    logger.debug @employees_data
  end

  def new
    @employers = Employer.all
  end

  def create
    if @survey.save
      redirect_to admin_survey_url(@survey), notice: 'Survey created successfully'
    else
      log_errors(@survey)
      redirect_to admin_surveys_url, alert: 'Survey creation failed. Check logs...'
    end
  end

  def edit
    Rails.logger.debug "Ping from admin/surveys#edit with params: #{params}"
  end

  def update
    Employee.filter_conducted_by_survey_id(@survey.id).each do |employee|
      params[:employees_ids] << String(employee.id) unless params[:employees_ids].include?(String(employee.id))
    end
    @survey.employee_ids = params[:employees_ids]
    if @survey.save
      redirect_to admin_survey_url(@survey), notice: 'Survey updated successfully'
    else
      log_errors(@survey)
      redirect_to admin_survey_url(@survey), alert: 'Survey update failed. Check logs...'
    end
  end

  def destroy
    if @survey.destroy
      redirect_to admin_surveys_url, notice: 'Survey deleted successfully'
    else
      redirect_to admin_survey_url(@survey), notice: 'Survey deletion failed. Check logs...'
    end
  end

  def search
    if params[:search].blank?
      redirect_to admin_surveys_url, alert: 'Search field empty'
    else
      @search_results = Survey.all
        .where('lower(label) LIKE :search_text', search_text: "%#{params[:search].downcase}%").page(params[:page])
    end
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
