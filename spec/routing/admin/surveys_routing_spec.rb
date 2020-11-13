require 'rails_helper'

RSpec.describe 'Routing to surveys as admin' do
  it 'routes /admin/surveys to admin/surveys#index' do
    expect(get: '/admin/surveys').to route_to(
      controller: 'admin/surveys',
      action: 'index'
    )
  end
  it 'routes /admin/surveys/1 to admin/surveys#show' do
    expect(get: '/admin/surveys/1').to route_to(
      controller: 'admin/surveys',
      action: 'show',
      id: '1'
    )
  end
  it 'routes /admin/surveys/new to admin/surveys#new' do
    expect(get: '/admin/surveys/new').to route_to(
      controller: 'admin/surveys',
      action: 'new'
    )
  end
  it 'routes /admin/surveys to admin/surveys#create' do
    expect(post: '/admin/surveys').to route_to(
      controller: 'admin/surveys',
      action: 'create'
    )
  end
  it 'routes /admin/surveys/1/edit to admin/surveys#edit' do
    expect(get: '/admin/surveys/1/edit').to route_to(
      controller: 'admin/surveys',
      action: 'edit',
      id: '1'
    )
  end
  it 'routes /admin/surveys/1 to admin/surveys#update' do
    expect(put: '/admin/surveys/1').to route_to(
      controller: 'admin/surveys',
      action: 'update',
      id: '1'
    )
  end
  it 'routes /admin/surveys/1 to admin/surveys#destroy' do
    expect(delete: '/admin/surveys/1').to route_to(
      controller: 'admin/surveys',
      action: 'destroy',
      id: '1'
    )
  end
end
