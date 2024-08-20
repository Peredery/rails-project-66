# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  scope module: 'web' do
    root 'home#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    delete 'auth/logout', to: 'auth#destroy'
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end
end
