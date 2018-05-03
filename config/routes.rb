Rails.application.routes.draw do
  resources :users, only: [:index] do
    collection { post :import }
  end
  root 'users#index'
end
