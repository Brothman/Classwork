Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :cat_rental_requests, only: [:create, :new]  do
    member do
      patch 'approve'
      patch 'deny'
    end
  end

end
