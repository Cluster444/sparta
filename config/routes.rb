Rails.application.routes.draw do
  resources :players do
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

  root to: redirect('/players')
end
