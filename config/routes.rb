Jukebox::Application.routes.draw do

  devise_for :users

  resources :users


  resources :releases


  resources :artist_members


  resources :artists


  resources :tracks


  resources :albums

  match '/mobile', :to => 'pages#index'
  match '/fullsite', :to => 'pages#index'

  root :to => 'pages#index'

end
