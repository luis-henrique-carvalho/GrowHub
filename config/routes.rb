# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, path: 'api/auth', path_names: {
    sign_in: :login,
    sign_out: :logout,
    registration: :signup
  }, controllers: {
    sessions: 'api/auth/sessions',
    registrations: 'api/auth/registrations'
  }

  devise_scope :user do
    post 'api/auth/refresh-token', to: 'api/auth/sessions#refresh_token'
  end

  scope :api, defaults: { format: :json }, module: :api do
    namespace :v1 do
      namespace :mentor do
        resources :profiles, only: %i[show update]
        resources :expertise_areas, only: %i[index]
      end
      resources :categories, only: %i[index create]
      resources :users, only: %i[show update]
      resources :transactions, only: %i[index create show update destroy]
      resources :dashboards, only: %i[index]
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
