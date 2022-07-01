# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }, path_names: { sign_in: "" }
  devise_for :employees
  
  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index create]
  root to: 'kudos#index'
  
  namespace :admins do
    get 'pages/dashboard', to: 'pages#dashboard'
    resources :kudos, only: %i[index destroy]
    resources :employees, only: %i[index edit update destroy]
    resources :company_values
    resources :rewards
    root to: 'pages#dashboard'
  end
end
