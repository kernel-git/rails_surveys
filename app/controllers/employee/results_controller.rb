# frozen_string_literal: true

class Employee::ResultsController < ApplicationController
  layout 'employee'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @results = Survey.filter_conducted_by_assigned_employee_id(current_account.employee.id).page(params[:page])
  end

  def show
    id = params.require(:id)
    @result = SurveyEmployeeRelation.includes(:employee, survey: 
      [question_groups: 
        [questions: 
          [options: :answers]
        ]
      ]
    ).find(id)

    @answers = {}
    @result.survey.question_groups.each do |qgroup|
      qgroup.questions.each do |question|
        question.options.each do |option|
          answer = Answer.filter_by_option_id_and_employee_id(option.id, current_account.employee.id)
          @answers[question.id.to_s.to_sym] = answer unless answer.empty?
        end
      end
    end
  rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing => e
    log_exception(e)
    redirect_to(employee_static_pages_url, page: 'not-found-404')
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employee'
  end
end
