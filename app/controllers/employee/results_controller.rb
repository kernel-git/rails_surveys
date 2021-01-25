# frozen_string_literal: true

class Employee::ResultsController < ApplicationController
  layout 'employee'
  load_and_authorize_resource class: 'SurveyEmployeeRelation'
  skip_load_resource only: :show

  def index
    @results = @results.page(params[:page])
  end

  def show
    @result = SurveyEmployeeRelation.includes(:employee, survey:
      [question_groups:
        [questions:
          [options: :answers]]]).find(params[:id])

    @answers = {}
    @result.survey.question_groups.each do |qgroup|
      qgroup.questions.each do |question|
        question.options.each do |option|
          answer = Answer.filter_by_option_id_and_employee_id(option.id, current_account.account_user_id)
          @answers[question.id.to_s.to_sym] = answer unless answer.empty?
        end
      end
    end
  end
end
