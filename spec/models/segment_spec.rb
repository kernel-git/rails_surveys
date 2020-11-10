require 'rails_helper'

RSpec.describe Segment, type: :model do
  it 'is valid with all valid attributes' do
    segment = Segment.new(label: 'client_label')
    expect(segment).to be_valid
  end

  it 'is not valid without a label' do
    segment = Client.new(label: nil)
    segment.valid?
    expect(segment.errors[:label]).to include('can\'t be blank')
  end
end
