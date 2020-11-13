require 'rails_helper'

RSpec.describe 'Routing to surveys as user' do
  it 'routes /surveys to user/surveys#index' do
    expect(get: '/surveys').to route_to(
      controller: 'user/surveys',
      action: 'index'
    )
  end
  it 'routes /surveys/1 to user/surveys#show' do
    expect(get: '/surveys/1').to route_to(
      controller: 'user/surveys',
      action: 'show',
      id: '1'
    )
  end
  it 'routes /surveys/1/edit to user/surveys#edit' do
    expect(get: '/surveys/1/edit').to route_to(
      controller: 'user/surveys',
      action: 'edit',
      id: '1'
    )
  end  
  it 'routes /surveys/1 to user/surveys#update' do
    expect(put: '/surveys/1').to route_to(
      controller: 'user/surveys',
      action: 'update',
      id: '1'
    )
  end
  it 'doesn\'t routes /surveys/new to user/surveys#new' do
    expect(get: '/surveys/new').not_to be_routable
  end
  it 'doesn\'t routes /surveys to user/surveys#create' do
    expect(post: '/surveys').not_to be_routable
  end
  it 'doesn\'t routes /surveys/1 to user/surveys#destroy' do
    expect(delete: '/surveys/1').not_to be_routable
  end
end
