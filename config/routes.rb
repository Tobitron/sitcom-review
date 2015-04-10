Rails.application.routes.draw do
  root 'sitcoms#index'
  devise_for :users

  resources :sitcoms do
    resources :reviews, except: [:index, :show]
  end

  resources :reviews, except: [:index, :show] do
    resources :comments, except: [:index, :show]
    resources :upvotes, only: [:create]
    resources :downvotes, only: [:create]
  end

  resources :searches, only: [:index]
end
