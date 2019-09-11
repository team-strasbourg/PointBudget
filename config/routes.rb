Rails.application.routes.draw do

  devise_for :users

  root :to => 'static_pages#landing_page'
  get 'static_pages/about'
  get 'static_pages/contact'
  resources :energies, only: [:show, :new]

  resources :gas_simulations
  resources :users
  resources :full_simulations

  namespace :admin do
    root :to =>'users#index'
    resources :users
    resources :energies, only: [:show]
    resources :gas_simulations
    resources :gas_contracts
    resources :full_simulations
  end

  resources :users do
     resources :full_simulations
    end

  namespace :users do
    root :to => "users#show"
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
