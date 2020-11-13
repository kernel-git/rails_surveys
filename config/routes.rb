Rails.application.routes.draw do
  namespace :admin do
    constraints(id: /[0-9]+/) do
      resources :users
      resources :segments
      resources :surveys
      resources :clients, only: [:index, :show] do
        get 'stats', on: :member
        get 'stats/live', on: :member, action: :live
        get 'stats/historical', on: :member, action: :historical
      end
    end
  end
  scope module: 'user' do
    resources :surveys, only: [:index, :show, :edit, :update], constraints: { id: /[0-9]+/ }
    resource :profile, controller: 'users', only: [:show, :edit, :update]
  end
  namespace :company do
    resource :profile, controller: 'clients', only: [:show, :edit, :update]
    get 'stats', controller: 'clients', action: :stats
    get 'stats/live', controller: 'clients', action: :live
    get 'stats/historical', controller: 'clients', action: :historical
  end

end
