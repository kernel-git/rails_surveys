require 'rails_helper'

RSpec.describe QuestionGroup, type: :model do
  it 'is valid with all valid attributes' do
    survey = Survey.new
    question_group = QuestionGroup.new(label: 'question_group_one')
    question_group.survey = survey
    expect(question_group).to be_valid
  end
  it 'is not valid without a label' do 
    question_group = QuestionGroup.new(label: nil)
    question_group.valid?
    expect(question_group.errors[:label]).to include('can\'t be blank')
  end
  it 'is not valid without a survey' do 
    question_group = QuestionGroup.new
    question_group.valid?
    expect(question_group.errors[:survey]).to include('must exist')
  end

end
