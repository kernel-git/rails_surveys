# frozen_string_literal: true

class Moderator::ResultsController < ApplicationController
  load_and_authorize_resource class: 'SurveyEmployeeConnection'
  skip_load_resource only: :show

  def index
    @results = @results.page(params[:page])
  end

  def show
    @result = SurveyEmployeeConnection.includes(:employee, survey:
      [question_groups:
        [questions:
          [options: :answers]]]).find(params[:id])

    @answers = {}
    @result.survey.question_groups.each do |qgroup|
      qgroup.questions.each do |question|
        question.options.each do |option|
          answer = Answer.filter_by_option_id_and_employee_id(option.id, @result.employee.id)
          @answers[question.id.to_s.to_sym] = answer unless answer.empty?
        end
      end
    end
  end
end
