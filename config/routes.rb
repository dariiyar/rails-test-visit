Rails.application.routes.draw do
  resources :users, only: [:index]
  root 'welcome#index'
end
