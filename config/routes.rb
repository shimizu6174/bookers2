Rails.application.routes.draw do
  get 'home/about'
	devise_for :users
  resources :books, only: [:new, :create, :index, :show]
  resources :users, only: [:show, :edit, :update]
  root to: 'home#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
