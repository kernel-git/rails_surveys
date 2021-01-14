require 'rails_helper'

RSpec.describe 'Routing to employers as employer' do
  it 'routes /employer/profile to employer/employers#show' do
    expect(get: '/employer/profile').to route_to(
      controller: 'employer/employers',
      action: 'show'
    )
  end
  it 'routes /employer/profile/edit to employer/employers#edit' do
    expect(get: '/employer/profile/edit').to route_to(
      controller: 'employer/employers',
      action: 'edit'
    )
  end
  it 'routes /employer/profile to employer/employers#update' do
    expect(put: '/employer/profile').to route_to(
      controller: 'employer/employers',
      action: 'update'
    )
  end
  it 'routes /employer/stats to employer/employers#stats' do
    expect(get: '/employer/stats').to route_to(
      controller: 'employer/employers',
      action: 'stats'
    )
  end
  it 'routes /employer/stats/live to employer/employers#live' do
    expect(get: '/employer/stats/live').to route_to(
      controller: 'employer/employers',
      action: 'live'
    )
  end
  it 'routes /employer/stats/historical to employer/employers#historical' do
    expect(get: '/employer/stats/historical').to route_to(
      controller: 'employer/employers',
      action: 'historical'
    )
  end
  it 'doesn\'t routes /employer/profile/new to employee/employees#new' do
    expect(get: '/employer/profile/new').not_to be_routable
  end
  it 'doesn\'t routes /employer/profile to employee/employees#create' do
    expect(post: '/employer/profile').not_to be_routable
  end
  it 'doesn\'t routes /employer/profile to employee/employees#destroy' do
    expect(delete: '/employer/profile').not_to be_routable
  end
end
