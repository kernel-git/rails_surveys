Rails.application.routes.draw do

  devise_for :accounts, path: 'account', controllers: {
    confirmations: 'account/confirmations',
    passwords: 'account/passwords',
    registrations: 'account/registrations',
    sessions: 'account/sessions',
    unlocks: 'account/unlocks'
  }

  namespace :account do
    root 'static_pages#show', page: 'home'
    get 'static-pages/:page', to: 'static_pages#show'
  end

  namespace :admin do
    root 'static_pages#show', page: 'home'
    get 'static-pages/:page', to: 'static_pages#show'

    constraints(id: /[0-9]+/) do # старый стиль
      resources :admins
      resources :employees
      resources :segments
      resources :surveys
      resources :results
      resources :employers do
        get 'stats-pages/:stats-id', to: 'stats#show'
      end
    end

  end
  namespace :employee do
    root 'static_pages#show', page: 'home'
    get 'static-pages/:page', to: 'static_pages#show'

    resources :surveys, only: [:index], constraints: { id: /[0-9]+/ } do # старый стиль
      member do
        get :attempt
        post :conduct
      end
    end
    resources :results, only: [:index, :show], constraints: { id: /[0-9]+/ } # старый стиль

  end
  namespace :employer do
    root 'static_pages#home' 
    get 'home', to: 'static_pages#home'

    constraints(id: /[0-9]+/) do # старый стиль
      resources :surveys
      resources :employees
      resources :segments
      resources :results, only: [:index, :show]
    end
  end

  root 'static_pages#show', page: 'home'
  get '/:page', to: 'static_pages#show', as: 'static_pages'

end
