require 'rails_helper'

RSpec.describe 'Routing to clients as admin' do
  it 'routes /admin/clients to admin/clients#index' do
    expect(get: '/admin/clients').to route_to(
      controller: 'admin/clients',
      action: 'index'
    )
  end
  it 'routes /admin/clients/1 to admin/clients#show' do
    expect(get: '/admin/clients/1').to route_to(
      controller: 'admin/clients',
      action: 'show',
      id: '1'
    )
  end
  it 'routes /admin/clients/1/stats to admin/clients#stats' do
    expect(get: '/admin/clients/1/stats').to route_to(
      controller: 'admin/clients',
      action: 'stats',
      id: '1'
    )
  end
  it 'routes /admin/clients/1/stats/live to admin/clients#live' do
    expect(get: '/admin/clients/1/stats/live').to route_to(
      controller: 'admin/clients',
      action: 'live',
      id: '1'
    )
  end
  it 'routes /admin/clients/1/stats/historical to admin/clients#historical' do
    expect(get: '/admin/clients/1/stats/historical').to route_to(
      controller: 'admin/clients',
      action: 'historical',
      id: '1'
    )
  end
  it 'doesn\'t routes admin/clients/new to admin/clients#new' do
    expect(get: 'admin/clients/new').not_to be_routable
  end
  it 'doesn\'t routes admin/clients/new to admin/clients#create' do
    expect(post: 'admin/clients/new').not_to be_routable
  end
  it 'doesn\'t routes admin/clients/1/edit to admin/clients#edit' do
    expect(get: 'admin/clients/1/edit').not_to be_routable
  end
  it 'doesn\'t routes admin/clients/1 to admin/clients#update' do
    expect(put: 'admin/clients/1').not_to be_routable
  end
  it 'doesn\'t routes admin/clients/1 to admin/clients#delete' do
    expect(delete: 'admin/clients/1').not_to be_routable
  end
end
