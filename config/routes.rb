Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'dashboards#index'

  resources :child_wishes, only: %i[new create]
  resources :dashboards, only: %i[index]
end
