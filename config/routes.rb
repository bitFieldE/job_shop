Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :users, except: [:new]
  resource :session, only: [:create, :destroy]
  get "/signup" => "users#new"
  root 'home#index'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
