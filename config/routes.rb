Rails.application.routes.draw do

  namespace :admin do
    root 'static_pages#show', page: 'home'
    get 'static-pages/:page', to: 'static_pages#show'

    constraints(id: /[0-9]+/) do # старый стиль
      resources :admins
      resources :users
      resources :segments
      resources :surveys
      resources :clients do
        get 'stats-pages/:stats-id', to: 'stats#show'
      end
    end

  end
  namespace :user do
    root 'static_pages#show', page: 'home'
    get 'static-pages/:page', to: 'static_pages#show'

    resources :surveys, only: [:index], constraints: { id: /[0-9]+/ } do # старый стиль
      member do
        get :attempt
        patch :conduct
        put :conduct
      end
    end

  end
  namespace :company do
    root 'static_pages#home' 
    get 'home', to: 'static_pages#home'

    constraints(id: /[0-9]+/) do # старый стиль
      resources :surveys
      resources :users
      resources :segments
      resources :results, only: [:index, :show]
    end
  end

  root 'static_pages#show', page: 'home'
  get 'static-pages/:page', to: 'static_pages#show'

end
