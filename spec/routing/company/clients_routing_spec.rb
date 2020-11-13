require 'rails_helper'

RSpec.describe 'Routing to clients as company' do

  it 'routes /company/profile to company/clients#show' do
    expect(get: '/company/profile').to route_to(
      controller: 'company/clients',
      action: 'show'
    )
  end
  it 'routes /company/profile/edit to company/clients#edit' do
    expect(get: '/company/profile/edit').to route_to(
      controller: 'company/clients',
      action: 'edit'
    )
  end
  it 'routes /company/profile to company/clients#update' do
    expect(put: '/company/profile').to route_to(
      controller: 'company/clients',
      action: 'update'
    )
  end
  it 'routes /company/stats to company/clients#stats' do
    expect(get: '/company/stats').to route_to(
      controller: 'company/clients',
      action: 'stats'
    )
  end
  it 'routes /company/stats/live to company/clients#live' do
    expect(get: '/company/stats/live').to route_to(
      controller: 'company/clients',
      action: 'live'
    )
  end
  it 'routes /company/stats/historical to company/clients#historical' do
    expect(get: '/company/stats/historical').to route_to(
      controller: 'company/clients',
      action: 'historical'
    )
  end
  it 'doesn\'t routes /company/profile/new to user/users#new' do
    expect(get: '/company/profile/new').not_to be_routable
  end
  it 'doesn\'t routes /company/profile to user/users#create' do
    expect(post: '/company/profile').not_to be_routable
  end
  it 'doesn\'t routes /company/profile to user/users#destroy' do
    expect(delete: '/company/profile').not_to be_routable
  end
end
