require 'rails_helper'

RSpec.describe Survey, type: :model do
  it 'is valid with all valid attributes' do
    survey = Survey.new(label: 'survey_label')
    expect(survey).to be_valid
  end

  it 'is not valid without a label' do
    survey = Survey.new(label: nil)
    survey.valid?
    expect(survey.errors[:label]).to include('can\'t be blank')
  end
end
