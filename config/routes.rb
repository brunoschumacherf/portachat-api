Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :webhooks do
        resources :users, only: [:create]
      end
    end
  end
end
