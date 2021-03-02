Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :new_users, :get_meters, :providers, only: :index
      resources :usages, only: :show
    end
  end
end
