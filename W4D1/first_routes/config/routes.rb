Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resource :users
  # get :users, to: "users#index"
  # get "users/:id", to: "users#show", as: 'shown_user'
  # get "users/edit", to: "users#edit"
  # patch "users/:id", to: "users#update"
  # put "users/:id", to: "users#update"
  # delete "users/:id", to: "users#destroy"
  # post "users", to: "users#create"

  resources :users, only: [:index, :show, :update, :destroy, :create]

  resources :artwork_shares, only: [:destroy, :create]

  resources :users do
    resources :artworks, only: [:index]
  end

  resources :artworks, only: [:show, :update, :destroy, :create]

  resources :comments, only: [:create, :destroy, :index]
end
