Jukebox::Application.routes.draw do

  devise_for :users

  resources :users


  resources :releases


  resources :artist_members


  resources :artists


  resources :tracks


  resources :albums

  match '/albums/:name/:uqid', :to => 'albums#show'

  match '/search', :to => 'pages#search'

  match '/mobile', :to => 'pages#index'
  match '/fullsite', :to => 'pages#index'

  root :to => 'pages#index'

end
