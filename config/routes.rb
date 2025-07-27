Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :destroy]
      post 'auth/login', to: 'authentication#create'
      namespace :webhooks do
        resources :users, only: [:create]
      end
    end
  end
end
