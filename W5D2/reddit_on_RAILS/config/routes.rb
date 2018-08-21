Rails.application.routes.draw do
  resources :posts do
    resources :comments, only:[:new]
  end
  resources :subs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  resources :comments, only: [:create, :show]
end
