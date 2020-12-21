class User::SurveysController < ApplicationController
  layout 'user'
  
  def index
    @avaible_surveys = Survey.filter_avaible_by_assigned_user_id(43).page(params[:page]) # temporal constant id
    @conducted_surveys = Survey.filter_conducted_by_assigned_user_id(43)
  end
  def attempt
    @survey = Survey.filter_avaible_by_assigned_user_id(43).find(params[:id]) # temporal constant id
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
        questions_data << question_data
      end
      qgroup_data << questions_data
      @qgroups_data << qgroup_data
    end
  end
  def conduct
    answers = []
    params[:answers].each do |question_id, answer_data|
      new_answer = Answer.new
      new_answer.answer_val = answer_data["answer_val"]
      new_answer.question = Question.find(question_id)
      new_answer.user = User.find(43) # temporal constant id
      unless new_answer.valid?
        puts "Answer is not valid. Error messages:"
        new_answer.errors.full_messages.each { |e| puts e}
        return
      end
      answers << new_answer
    end
    begin 
      answers.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      puts "Answer save failed. Exception type: #{e.class.name}, exception message: #{e.message}"
      redirect_to user_surveys_url 
    else
      relation = SurveyUserRelation.where(survey_id: params[:id], user_id: 43).first # temporal constant id
      relation.is_conducted = true
      relation.save
      
      redirect_to user_surveys_url
    end
  end
end
