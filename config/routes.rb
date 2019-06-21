require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'

  resources :scraper_expressions, only: [:index, :new, :destroy, :create]

  namespace :api do
    namespace :v1 do
      resources :products, except: [:edit, :update] do
        member do
          get :fetch
        end
      end
    end
  end

end
