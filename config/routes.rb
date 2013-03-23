Jukebox::Application.routes.draw do

  resources :playlists


  devise_for :users do
    get 'signout' => 'devise/sessions#destroy'
  end

  resources :users


  resources :releases


  resources :artist_members


  resources :artists


  resources :tracks


  resources :albums

  match '/albums/:name/:uqid', :to => 'albums#show'

  match '/home', :to => 'pages#home'
  match '/search', :to => 'pages#search'
  match '/browse', :to => 'pages#browse'

  match '/mobile', :to => 'pages#index'
  match '/fullsite', :to => 'pages#index'

  root :to => 'pages#index'

end
