# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing to surveys as employee' do
  it 'routes /surveys to employee/surveys#index' do
    expect(get: '/surveys').to route_to(
      controller: 'employee/surveys',
      action: 'index'
    )
  end
  it 'routes /surveys/1 to employee/surveys#show' do
    expect(get: '/surveys/1').to route_to(
      controller: 'employee/surveys',
      action: 'show',
      id: '1'
    )
  end
  it 'routes /surveys/1/edit to employee/surveys#edit' do
    expect(get: '/surveys/1/edit').to route_to(
      controller: 'employee/surveys',
      action: 'edit',
      id: '1'
    )
  end
  it 'routes /surveys/1 to employee/surveys#update' do
    expect(put: '/surveys/1').to route_to(
      controller: 'employee/surveys',
      action: 'update',
      id: '1'
    )
  end
  it 'doesn\'t routes /surveys/new to employee/surveys#new' do
    expect(get: '/surveys/new').not_to be_routable
  end
  it 'doesn\'t routes /surveys to employee/surveys#create' do
    expect(post: '/surveys').not_to be_routable
  end
  it 'doesn\'t routes /surveys/1 to employee/surveys#destroy' do
    expect(delete: '/surveys/1').not_to be_routable
  end
end
