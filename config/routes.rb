# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }, path_names: { sign_in: "" }
  devise_for :employees
  resources :kudos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'kudos#index'
  
  namespace :admins do
    get 'pages/dashboard', to: 'pages#dashboard'
    delete 'pages/dashboard/kudo(/:id)', to: 'pages#destroy_kudo', as: :pages_destroy_kudo
    root to: 'pages#dashboard'
  end

end
