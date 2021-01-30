# frozen_string_literal: true

class Admin::ResultsController < ApplicationController
  # layout 'admin'
  load_and_authorize_resource class: 'SurveyEmployeeConnection'

  def index
    @results = @results.page(params[:page])
  end

  def show
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
