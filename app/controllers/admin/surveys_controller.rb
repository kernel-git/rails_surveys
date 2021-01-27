# frozen_string_literal: true

class Admin::SurveysController < ApplicationController
  layout 'admin'
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
    @results = SurveyEmployeeConnection.where(survey_id: params[:id], is_conducted: true).includes(:employee)
  end

  def new
    @employers = Employer.all
  end

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
    Rails.logger.debug "Ping from admin/surveys#update with params: #{params}"
  end

  def destroy
    Rails.logger.debug "Ping from admin/surveys#destroy with params: #{params}"
  end

  protected

  def survey_params
    params.require(:survey).permit(:label, :employer_id)
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
