Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"

  resources :articles do
    resources :comments
  end

  get "signup" => "users#new"
  resources :users

  get "login" => "sessions#new"
  post "login" => "sessions#create"

  delete "logout" => "sessions#destroy"
  

  # Defines the root path route ("/")
  # root "articles#index"
end
