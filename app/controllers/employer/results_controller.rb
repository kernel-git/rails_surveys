# frozen_string_literal: true

class Employer::ResultsController < ApplicationController
  layout 'employer'
  before_action :check_account_type, if: :authenticate_account!

  def index
    @results = SurveyEmployeeRelation.filter_conducted_by_employer_id(current_account.employer.id).page(params[:page])
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
    @answers_data = {}
    @result.survey.question_groups.each do |qgroup|
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
  rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing => e
    log_exception(e)
    redirect_to(employer_static_pages_url, page: 'not-found-404')
  end

  protected

  def check_account_type
    redirect_to(static_pages_url(page: 'not-found-404')) unless current_account.account_type == 'employer'
  end
end
