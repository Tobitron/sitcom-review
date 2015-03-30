Rails.application.routes.draw do
  resources :sitcoms

  root 'sitcoms#index'
  devise_for :users
end
