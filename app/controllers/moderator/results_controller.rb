# frozen_string_literal: true

class Moderator::ResultsController < ApplicationController
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

  def destroy
    if Answer.where(survey_employee_connection: @result).destroy_all
      @result.is_conducted = false
      @result.save
      redirect_to moderator_results_url, 
        notice: 'Result deleted successfully. Now employee can conduct survey one more time.'
    else
      redirect_to moderator_result_url(@result), notice: 'Result deletion failed. Check logs...'
    end
  end
end
