Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'dashboards#index'

  # API routes
  namespace :api do
    namespace :v1 do
      resources :child_wishes, only: %i[index], defaults: { format: :json }
    end
  end

  resources :child_wishes, only: %i[new create]
  resources :dashboards, only: %i[index]
end
