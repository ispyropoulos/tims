Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, default: { format: 'json' } do
    namespace :v1 do
      resources :disruptions, only: [:index]
    end
  end

  resources :disruptions, only: [:index]
end
