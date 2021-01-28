# frozen_string_literal: true

class Employee::SurveysController < ApplicationController
  layout 'employee'
  load_resource only: :attempt
  authorize_resource

  def index
    @connections = SurveyEmployeeConnection.filter_by_employee_id(current_account.account_user_id)
      .filter_avaible.page(params[:page])
  end

  def attempt
  end

  def conduct
    answers = Array.new
    answers_params[:answers].each_value do |answer_data|
      answers << Answer.new(
        employee: current_account.account_user,
        option_id: answer_data[:option_id],
        additional_text: (Option.find(answer_data[:option_id]).has_text_field ? answer_data[:additional_text] : '')
      )
      if answers.last.invalid?
        log_errors(answers.last)
        redirect_to attempt_employee_survey_url(params[:id]), alert: 'Attempt save failed. Check logs...'
        return
      end
    end
    
    result = SurveyEmployeeConnection.find_by(
      survey_id: params[:id],
      employee_id: current_account.account_user_id
    )
    result.assign_attributes(is_conducted: true)
    if answers.each(&:save) && result.save
      redirect_to employee_surveys_url, notice: 'Attempt saved successfully'
    else
      log_errors(result)
      redirect_to attempt_employee_survey_url(params[:id]), alert: 'Attempt save failed. Check logs...'
    end
  end

  protected

  def answers_params
    params.permit(
      answers: [
        %i[
          option_id
          additional_text
        ]
      ]
    )
  end
end
