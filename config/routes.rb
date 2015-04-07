Rails.application.routes.draw do
  root 'sitcoms#index'
  devise_for :users

  resources :sitcoms do
    resources :reviews
  end

  resources :reviews do
    resources :comments
    resources :upvotes, only: [:create]
    resources :downvotes, only: [:create]
  end
end
