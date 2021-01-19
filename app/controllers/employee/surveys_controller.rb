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
    current_employee = current_account.employee
    answers = []
    params[:answers].each do |_question_id, answer_data|
      new_answer = Answer.new
      option = Option.find(answer_data['option_data'])
      new_answer.option = option
      new_answer.additional_text = answer_data['additional_text'] if option.has_text_field
      new_answer.employee = Employee.find(current_employee.id)
      unless new_answer.valid?
        Rails.logger.error 'Answer is not valid. Error messages:'
        new_answer.errors.full_messages.each { |e| Rails.logger.error e }
        return
      end
      answers << new_answer
    end
    begin
      answers.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
      flash.alert = 'Attempt save failed. Check logs...'
      redirect_to employee_surveys_url
    else
      relation = SurveyEmployeeRelation.where(survey_id: params[:id], employee_id: current_employee.id).first
      relation.is_conducted = true
      relation.save

      flash.notice = 'Attempt saved successfully'
      redirect_to employee_surveys_url
    end
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'employee'
  end
end
