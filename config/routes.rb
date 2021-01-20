# frozen_string_literal: true

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
    constraints(id: /[0-9]+/) do # старый стиль
      resources :admins
      resources :employees
      resources :segments
      resources :surveys
      resources :results
      resources :employers
    end
    root 'static_pages#show', page: 'home'
    get '/:page', to: 'static_pages#show', as: 'static_pages'
  end
  namespace :employee do
    resources :surveys, only: [:index], constraints: { id: /[0-9]+/ } do # старый стиль
      member do
        get :attempt
        post :conduct
      end
    end
    resources :results, only: %i[index show], constraints: { id: /[0-9]+/ } # старый стиль
    root 'static_pages#show', page: 'home'
    get '/:page', to: 'static_pages#show', as: 'static_pages'
  end
  namespace :employer do
    constraints(id: /[0-9]+/) do # старый стиль
      resources :surveys
      resources :employees
      resources :segments
      resources :results
    end
    root 'static_pages#show', page: 'home'
    get '/:page', to: 'static_pages#show', as: 'static_pages'
  end

  root 'static_pages#show', page: 'home'
  get '/:page', to: 'static_pages#show', as: 'static_pages'
end
