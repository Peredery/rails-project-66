# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  scope module: 'web' do
    root 'home#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    delete 'auth/logout', to: 'auth#destroy'
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resources :repositories, only: %i[index show new create] do
      resources :checks, only: %i[create show], module: 'repositories'
    end
  end

  namespace :api do
    resources :checks, only: %i[create]
  end
end
