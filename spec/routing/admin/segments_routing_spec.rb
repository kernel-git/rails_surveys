# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Route to segments as admin' do
  it 'routes /admin/employees to admin/employees#index' do
    expect(get: '/admin/employees').to route_to(
      controller: 'admin/employees',
      action: 'index'
    )
  end
  it 'routes /admin/employees/1 to admin/employees#show' do
    expect(get: '/admin/employees/1').to route_to(
      controller: 'admin/employees',
      action: 'show',
      id: '1'
    )
  end
  it 'routes /admin/employees/new to admin/employees#new' do
    expect(get: '/admin/employees/new').to route_to(
      controller: 'admin/employees',
      action: 'new'
    )
  end
  it 'routes /admin/employees to admin/employees#create' do
    expect(post: '/admin/employees').to route_to(
      controller: 'admin/employees',
      action: 'create'
    )
  end
  it 'routes /admin/employees/1/edit to admin/employees#edit' do
    expect(get: '/admin/employees/1/edit').to route_to(
      controller: 'admin/employees',
      action: 'edit',
      id: '1'
    )
  end
  it 'routes /admin/employees/1 to admin/employees#update' do
    expect(put: '/admin/employees/1').to route_to(
      controller: 'admin/employees',
      action: 'update',
      id: '1'
    )
  end
  it 'routes /admin/employees/1 to admin/employees#destroy' do
    expect(delete: '/admin/employees/1').to route_to(
      controller: 'admin/employees',
      action: 'destroy',
      id: '1'
    )
  end
end
