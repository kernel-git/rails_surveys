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
    resources :administrators
    resources :moderators
    resources :employees do
      get 'search', on: :collection
    end
    resources :groups
    resources :surveys, except: :edit do
      get 'search', on: :collection
      get 'statistic', on: :member
      get 'statistic', on: :collection
    end
    resources :results, except: %i[edit update]
    resources :employers
    root 'static_pages#show', page: 'home'
    get '/:page', to: 'static_pages#show', as: 'static_pages'
  end

  namespace :moderator do
    resources :moderators
    resources :surveys, except: :edit do
      get 'search', on: :collection
      get 'statistic', on: :member
      get 'statistic', on: :collection
    end
    resources :employees do
      get 'search', on: :collection
    end
    resources :groups, except: :destroy
    resources :results, except: %i[edit update]
    root 'static_pages#show', page: 'home'
    get '/:page', to: 'static_pages#show', as: 'static_pages'
  end

  namespace :employee do
    resources :surveys, only: [:index] do
      member do
        get :attempt
        post :conduct
      end
    end
    resources :results, only: %i[index show]
    root 'static_pages#show', page: 'home'
    get '/:page', to: 'static_pages#show', as: 'static_pages'
  end

  root 'static_pages#show', page: 'home'
  get '/:page', to: 'static_pages#show', as: 'static_pages'
end
