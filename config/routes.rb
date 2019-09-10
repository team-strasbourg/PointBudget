Rails.application.routes.draw do

  get 'full_simulations/new'
  get 'full_simulations/create'
  get 'full_simulations/update'
  get 'full_simulations/edit'
  get 'full_simulations/destroy'
  get 'full_simulations/index'
  get 'full_simulations/show'
  devise_for :users

  root :to => "static_pages#landing_page"
  get 'static_pages/about'
  get 'static_pages/contact'
  resources :energies, only: [:show]

  resources :gas_simulations
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
