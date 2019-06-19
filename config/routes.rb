Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resource :product do
        member do
          post :fetch
        end
      end
    end
  end

  get '/*path', to: 'product#index'
  root 'product#index'
end
