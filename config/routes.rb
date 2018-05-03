Rails.application.routes.draw do
  resources :users, only: %i[index destroy] do
    collection { post :import }
  end
  root 'users#index'
end
