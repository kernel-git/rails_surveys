# frozen_string_literal: true

class Employee::SurveysController < ApplicationController
  layout 'employee'
  load_resource only: :attempt
  authorize_resource

  def index
    @surveys = Survey.filter_avaible_by_assigned_employee_id(current_account.account_user.id).page(params[:page])
  end

  def attempt
    # @survey = Survey.filter_avaible_by_assigned_employee_id(current_account.employee.id).find(params[:id])
  end

  def conduct
    answers = []
    begin
      answers_params[:answers].each_value do |answer_data|
        option = Option.find(answer_data[:option_data])
        answer = Answer.new(
          employee: current_account.account_user,
          option: option,
          additional_text: (option.has_text_field ? answer_data[:additional_text] : '')
        )
        raise ActiveRecord::RecordInvalid, answer.errors.full_messages if answer.invalid?

        answers << answer
      end
    rescue ActiveRecord::RecordInvalid
      log_exception(e)
      redirect_to attempt_employee_survey_url(params[:id]), alert: 'Attempt save failed. Check logs...'
    else
      result = SurveyEmployeeConnection.find_by(
        survey_id: params[:id],
        employee_id: current_account.account_user_id
      )
      result.is_conducted = true
      if result.save && answers.each(&:save)
        redirect_to employee_surveys_url, notice: 'Attempt saved successfully'
      else
        log_errors(result)
        log_errors(answers.each)
        redirect_to attempt_employee_survey_url(params[:id]), alert: 'Attempt save failed. Check logs...'
      end
    end

    #   permitted_params = params.permit(
    #     :id,
    #     answers: [
    #       %i[
    #         option_data
    #         additional_text
    #       ]
    #     ]
    #   )
    #   logger.debug permitted_params
    #   current_employee = current_account.employee
    #   answers = []
    #   permitted_params[:answers].each do |_question_id, answer_data|
    #     new_answer = Answer.new
    #     option = Option.find(answer_data['option_data'])
    #     new_answer.additional_text = answer_data['additional_text'] if option.has_text_field
    #     new_answer.employee = Employee.find(current_account.employee.id)
    #     new_answer.option = option

    #     raise ActiveRecord::RecordInvalid, new_answer.errors.full_messages unless new_answer.valid?

    #     answers << new_answer
    #   end
    #   answers.each(&:save!)
    #   connection = SurveyEmployeeConnection.where(survey_id: params[:id], employee_id: current_employee.id).first
    #   connection.is_conducted = true
    #   connection.save
    # rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActionController::ParameterMissing => e
    #   log_exception(e)
    #   flash.alert = 'Attempt save failed. Check logs...'
    #   redirect_to employee_surveys_url
    # else
    #   flash.notice = 'Attempt saved successfully'
    #   redirect_to employee_surveys_url
  end

  protected

  def answers_params
    params.permit(
      answers: [
        %i[
          option_data
          additional_text
        ]
      ]
    )
  end
end
