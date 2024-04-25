# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
                   path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  get 'render/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'render#index'
  # config/routes.rb

  resources :initiatives
  resources :events

  resources :initiatives do
    resources :requests, only: [:index]
  end

  #quitar rol a usuario
  resources :initiatives do
    resources :user_roles do
      member do
        delete 'destroy', as: 'remove'
      end
    end
  end

  resources :events do
    attendant do
      post 'add_user_role', to: 'events#update', as: 'add_user_role'
    end
  end

  resources :events do
    attendant do
      delete 'remove_user_role', to: 'events#leave', as: 'remove_user_role'
    end
  end



resources :requests, only: [:create, :update]

resources :initiatives do
  resources :events, only: [:new, :create]
end

end
