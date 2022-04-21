# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin', controllers: { sessions: 'admin_users/sessions' }
  devise_for :employees
  resources :kudos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'kudos#index'
  namespace :admin do
    root to: redirect('/admin/pages/dashboard')
    get 'pages/dashboard'
  end

end
