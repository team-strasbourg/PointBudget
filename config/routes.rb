Rails.application.routes.draw do

  devise_for :users

  root :to => 'static_pages#landing_page'
  get 'static_pages/about'
  get 'static_pages/contact'
  resources :energies, only: [:show]

  resources :gas_simulations
  resources :users

  namespace :admin do
    root :to =>'users#index'
    resources :users
    resources :energies, only: [:show]
    resources :gas_simulations
    resources :full_simulations
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
