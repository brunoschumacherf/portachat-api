Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :rooms do
        get "messages/index"
        get "messages/create"
      end
      get "rooms/index"
      get "rooms/create"
      resources :users, only: [:index, :destroy]
      post 'auth/login', to: 'authentication#create'
      namespace :webhooks do
        resources :users, only: [:create]
      end

      resources :rooms, only: [:index, :create] do
        resources :messages, only: [:index, :create], module: :rooms
      end
    end
  end
end
