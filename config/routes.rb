Rails.application.routes.draw do
  root 'sitcoms#index'
  devise_for :users

  resources :sitcoms do
    resources :reviews
  end

  resources :reviews do
    resources :comments
    resources :upvotes, only: [:index, :new, :create, :edit, :update]
    resources :downvotes, only: [:index, :new, :create, :edit, :update]
  end
end
