Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: [:create, :new] do
    member do
      get :notify_email
    end
  end
  
  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
