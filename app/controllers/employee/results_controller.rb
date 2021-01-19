# frozen_string_literal: true

class Employee::ResultsController < ApplicationController
  layout 'employee'
  before_action :check_account_type, if: :authenticate_account!

  def index
    current_employee = current_account.employee
    @results = Survey.filter_conducted_by_assigned_employee_id(current_employee.id).page(params[:page])
  end

  def show
    @result = SurveyEmployeeRelation.includes(:employee, survey: [question_groups: [questions: [options: :answers]]]).find(params[:id])
    @survey = @result.survey
    @answers_data = {}
    @survey.question_groups.each do |qgroup|
      qgroup.questions.each do |question|
        question.options.each do |option|
          option.answers.each do |answer|
            next unless answer.employee == @result.employee

            answer_array = []
            answer_array << answer.option_id
            answer_array << answer.additional_text if option.has_text_field
            @answers_data[question.id.to_s.to_sym] = answer_array
          end
        end
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    log_exception(e)
    render('admin/static_pages/not_found_404')
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'employee'
  end
end
