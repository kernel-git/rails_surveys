# frozen_string_literal: true

class Employee::SurveysController < ApplicationController
  layout 'employee'
  before_action :check_account_type, if: :authenticate_account!

  def index
    current_employee = current_account.employee
    @avaible_surveys = Survey.filter_avaible_by_assigned_employee_id(current_account.employee.id).page(params[:page])
    @conducted_surveys = Survey.filter_conducted_by_assigned_employee_id(current_account.employee.id)
  end

  def attempt
    @survey = Survey.filter_avaible_by_assigned_employee_id(current_account.employee.id).find(params[:id])
    @answer = Answer.new
    @qgroup = QuestionGroup.new
    @text_field_id = 0
    @option_radio_value = 0
    @question_id = 0

    @qgroups_data = []
    @survey.question_groups.each do |qgroup|
      qgroup_data = []
      qgroup_data << qgroup.label
      questions_data = []
      qgroup.questions.each do |question|
        question_data = []
        question_data << question.id
        question_data << question.question_type
        options_data = []
        question.options.each do |option|
          options_data << [option.id, option.text, option.has_text_field]
        end
        question_data << options_data
        questions_data << question_data
      end
      qgroup_data << questions_data
      @qgroups_data << qgroup_data
    end
  end

  def conduct
      permitted_params = params.permit(
        :id,
        answers: [
          [
            :option_data,
            :additional_text
          ]
        ]
      )
      logger.debug permitted_params
      current_employee = current_account.employee
      answers = []
      permitted_params[:answers].each do |_question_id, answer_data|
        new_answer = Answer.new
        option = Option.find(answer_data['option_data'])
        new_answer.additional_text = answer_data['additional_text'] if option.has_text_field
        new_answer.employee = Employee.find(current_account.employee.id)
        new_answer.option = option

        unless new_answer.valid?
          raise ActiveRecord::RecordInvalid, new_answer.errors.full_messages
        end
        answers << new_answer
      end
      answers.each(&:save!)
      relation = SurveyEmployeeRelation.where(survey_id: params[:id], employee_id: current_employee.id).first
      relation.is_conducted = true
      relation.save
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActionController::ParameterMissing => e
      log_exception(e)
      flash.alert = 'Attempt save failed. Check logs...'
      redirect_to employee_surveys_url
    else
      flash.notice = 'Attempt saved successfully'
      redirect_to employee_surveys_url
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employee'
  end
end
