require 'rails_helper'

RSpec.describe 'Routing to profile as user' do
  it 'routes /profile to user/users#show' do
    expect(get: '/profile').to route_to(
      controller: 'user/users',
      action: 'show'
    )
  end
  it 'routes /profile/edit to user/users#edit' do
    expect(get: '/profile/edit').to route_to(
      controller: 'user/users',
      action: 'edit'
    )
  end  
  it 'routes /profile to user/users#update' do
    expect(put: '/profile').to route_to(
      controller: 'user/users',
      action: 'update'
    )
  end
  it 'doesn\'t routes /profile/new to user/users#new' do
    expect(get: '/profile/new').not_to be_routable
  end
  it 'doesn\'t routes /profile to user/users#create' do
    expect(post: '/profile').not_to be_routable
  end
  it 'doesn\'t routes /profile to user/users#destroy' do
    expect(delete: '/profile').not_to be_routable
  end
end
