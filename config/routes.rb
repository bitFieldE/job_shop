Rails.application.routes.draw do
  resources :users, except: [:new]
  resource :session, only: [:create, :destroy]
  get "/signup" => "users#new"
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
