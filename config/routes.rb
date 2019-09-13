Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: :registrations }

  root to: 'static_pages#landing_page'
  get 'static_pages/about'
  #get 'static_pages/about', as: :about
  get 'static_pages/contact'


  namespace :admin do
    root to: 'users#index'
    resources :users
    resources :energies, only: [:show]
    resources :gas_simulations, only: %i[new create]
    resources :gas_contracts
    resources :full_simulations
  end

  resources :users, only: %i[show edit update] do
    root to: 'users#show'
    resources :full_simulations do
      resources :energies, only: %i[show new]
      resources :gas_simulations
    end
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
