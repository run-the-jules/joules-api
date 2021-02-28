Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :meter_activation, only: :index
      resources :usages, only: :show
      resources :friendships, only: %i[index create]
    end
  end
end
