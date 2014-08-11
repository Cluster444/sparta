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
  root to: redirect('/players')
end
