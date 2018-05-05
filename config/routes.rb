Rails.application.routes.draw do
  resources :users, only: %i[index destroy] do
    collection { post :import }
  end
  post 'users' => 'users#index', as: :filter_users
  root 'users#index'
end
