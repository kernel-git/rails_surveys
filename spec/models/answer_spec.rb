require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'is valid with all valid attributes' do
    employee = Employee.new
    question = Question.new
    answer = Answer.new(answer_val: 1.0)
    answer.question = question
    answer.employee = employee
    expect(answer).to be_valid
  end

  it 'is not valid without an answer val' do
    answer = Answer.new(answer_val: nil)
    answer.valid?
    expect(answer.errors[:answer_val]).to include('can\'t be blank')
  end

  it 'is not valid without an employee' do
    answer = Answer.new
    answer.valid?
    expect(answer.errors[:employee]).to include('must exist')
  end

  it 'is not valid without a question' do
    answer = Answer.new
    answer.valid?
    expect(answer.errors[:question]).to include('must exist')
  end
end
