Rails.application.routes.draw do

  namespace :admin do
    root 'static_pages#home'
    get 'home', to: 'static_pages#home'
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
    root 'static_pages#home'
    get 'home', to: 'static_pages#home'
    resources :surveys, only: [:index, :show, :edit, :update], constraints: { id: /[0-9]+/ } # старый стиль
    resource :profile, controller: 'users', only: [:show, :edit, :update]
  end
  namespace :company do
    root 'static_pages#home' 
    get 'home', to: 'static_pages#home'
    resources :surveys
    resources :users
    resources :segments
  end

  root 'static_pages#show'

  get 'static-pages/:id', to: 'static_pages#show'

  # get 'pages/:id', to: 'pages#show' # PagesController: render pages/#{params[:id]}
end
