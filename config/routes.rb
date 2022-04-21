# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :employees
  resources :kudos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'kudos#index'

  get '/admin', to: redirect('/admin/sign_in')

end
