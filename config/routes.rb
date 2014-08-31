Rails.application.routes.draw do
  root to: 'pages#show', id: 'home'

  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations"
  }

  resources :players, except: [:new, :create, :destroy] do
    member do
      get :raiding
      get :positions
    end

    resources :cities do
      resources :raids
      resources :scouts
    end
  end

  namespace :api, defaults: {format: 'json'} do
    resources :players, only: [:show] do
      resources :cities, except: [:new, :edit]  do
        resources :raids, except: [:new, :edit]
        resources :scouts, except: [:new, :edit]
      end
    end
  end
end
