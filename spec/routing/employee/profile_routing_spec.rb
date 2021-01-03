require 'rails_helper'

RSpec.describe 'Routing to profile as employee' do
  it 'routes /profile to employee/employees#show' do
    expect(get: '/profile').to route_to(
      controller: 'employee/employees',
      action: 'show'
    )
  end
  it 'routes /profile/edit to employee/employees#edit' do
    expect(get: '/profile/edit').to route_to(
      controller: 'employee/employees',
      action: 'edit'
    )
  end  
  it 'routes /profile to employee/employees#update' do
    expect(put: '/profile').to route_to(
      controller: 'employee/employees',
      action: 'update'
    )
  end
  it 'doesn\'t routes /profile/new to employee/employees#new' do
    expect(get: '/profile/new').not_to be_routable
  end
  it 'doesn\'t routes /profile to employee/employees#create' do
    expect(post: '/profile').not_to be_routable
  end
  it 'doesn\'t routes /profile to employee/employees#destroy' do
    expect(delete: '/profile').not_to be_routable
  end
end
