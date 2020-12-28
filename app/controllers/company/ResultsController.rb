class Company::ResultsController < ApplicationController
  layout 'company'
  before_action :authenticate_client!

  def index
    @results = SurveyUserRelation.filter_conducted_by_client_id(current_client.id).page(params[:page])
  end
  def show
    puts "params[:id]: #{params[:id]}"
    begin
      @result = SurveyUserRelation.find(params[:id])
      @survey = Survey.find(@result.survey_id)
      @user = User.find(@result.user_id)
      @answers = Answer.filter_by_user_id_and_survey_id(@result.user_id, @result.survey_id)
      @answers_wrapper = {}
      @answers.each do |answer|
        @answers_wrapper[answer.question_id] = answer
      end
      p @answers_wrapper
    rescue ActiveRecord::RecordNotFound => e 
      render("user/static_pages/not_found_404")
    else
      @answers.each { |a| p a.id }  
    end
  end
end
