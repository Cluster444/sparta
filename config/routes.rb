Rails.application.routes.draw do
  resources :players do
    resources :cities do
      resources :raids
      resources :scouts
    end
  end
  root to: redirect('/players')
end
