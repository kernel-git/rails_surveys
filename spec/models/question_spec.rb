require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'is valid with all valid attributes' do
    question_group = QuestionGroup.new
    question = Question.new(
      question_type: 'simple',
      benchmark_val: 1,
      benchmark_vol: 1
    )
    question.question_group = question_group
    expect(question).to be_valid
  end

  it 'is not valid without a question type' do
    question = Question.new(question_type: nil)
    question.valid?
    expect(question.errors[:question_type]).to include('can\'t be blank')
  end

  it 'is not valid without a benchmark val' do
    question = Question.new(benchmark_val: nil)
    question.valid?
    expect(question.errors[:benchmark_val]).to include('can\'t be blank')
  end

  it 'is not valid without a benchmark vol' do
    question = Question.new(benchmark_vol: nil)
    question.valid?
    expect(question.errors[:benchmark_vol]).to include('can\'t be blank')
  end

  it 'is not valid without a question group' do
    question = Question.new
    question.valid?
    expect(question.errors[:question_group]).to include('must exist')
  end
end
