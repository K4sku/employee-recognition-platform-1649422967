# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }, path_names: { sign_in: "" }
  devise_for :employees

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  
  resources :kudos
  resources :rewards, only: %i[index show], concerns: :paginatable
  resources :orders, only: %i[index create]
  root to: 'kudos#index'
  
  namespace :admins do
    get 'pages/dashboard', to: 'pages#dashboard'
    resources :kudos, only: %i[index destroy]
    resources :employees, only: %i[index show edit update destroy] do
      get 'add_kudos', on: :collection, to: 'employees#add_kudos_form'
      patch 'add_kudos', on: :collection
    end
    resources :company_values
    resources :rewards
    resources :orders, only: %i[index] do
        put 'deliver', on: :member
        get 'csv_export', on: :collection, to: 'orders#csv_export'
    end
    resources :categories
    root to: 'pages#dashboard'
  end
end
