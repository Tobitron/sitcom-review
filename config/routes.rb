Rails.application.routes.draw do
  root 'sitcoms#index'
  devise_for :users

  resources :sitcoms
  resources :reviews
end
