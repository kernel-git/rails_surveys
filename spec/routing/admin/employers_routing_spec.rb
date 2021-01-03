require 'rails_helper'

RSpec.describe 'Routing to employers as admin' do
  it 'routes /admin/employers to admin/employers#index' do
    expect(get: '/admin/employers').to route_to(
      controller: 'admin/employers',
      action: 'index'
    )
  end
  it 'routes /admin/employers/1 to admin/employers#show' do
    expect(get: '/admin/employers/1').to route_to(
      controller: 'admin/employers',
      action: 'show',
      id: '1'
    )
  end
  it 'routes /admin/employers/1/stats to admin/employers#stats' do
    expect(get: '/admin/employers/1/stats').to route_to(
      controller: 'admin/employers',
      action: 'stats',
      id: '1'
    )
  end
  it 'routes /admin/employers/1/stats/live to admin/employers#live' do
    expect(get: '/admin/employers/1/stats/live').to route_to(
      controller: 'admin/employers',
      action: 'live',
      id: '1'
    )
  end
  it 'routes /admin/employers/1/stats/historical to admin/employers#historical' do
    expect(get: '/admin/employers/1/stats/historical').to route_to(
      controller: 'admin/employers',
      action: 'historical',
      id: '1'
    )
  end
  it 'doesn\'t routes admin/employers/new to admin/employers#new' do
    expect(get: 'admin/employers/new').not_to be_routable
  end
  it 'doesn\'t routes admin/employers/new to admin/employers#create' do
    expect(post: 'admin/employers/new').not_to be_routable
  end
  it 'doesn\'t routes admin/employers/1/edit to admin/employers#edit' do
    expect(get: 'admin/employers/1/edit').not_to be_routable
  end
  it 'doesn\'t routes admin/employers/1 to admin/employers#update' do
    expect(put: 'admin/employers/1').not_to be_routable
  end
  it 'doesn\'t routes admin/employers/1 to admin/employers#delete' do
    expect(delete: 'admin/employers/1').not_to be_routable
  end
end
