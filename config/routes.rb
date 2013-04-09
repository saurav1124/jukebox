Jukebox::Application.routes.draw do

  devise_for :users do
    get 'signout' => 'devise/sessions#destroy'
  end

  resources :users

  resources :releases

  resources :artist_members

  resources :artists do
    member do
      get   :tracks
    end
  end

  resources :tracks, :path => "songs" do
    member do
      get   :details
    end
  end

  resources :albums do
    member do
      get   :tracks
    end
  end

  match '/albums/:name/:uqid', :to => 'albums#show'
  
  resources :playlists do
    collection do
      get   :selector
      post  :add_new
    end
    member do
      post  :add_track
      post  :remove_track
      get   :tracks
    end
  end

  match '/account', :to => 'account#index'
  match '/account/password', :to => 'account#password'
  match '/account/photo', :to => 'account#photo'
  match '/account/friends', :to => 'account#friends'

  match '/request_invite', :to => "pages#request_invite"
  match '/home', :to => 'pages#home'
  match '/thanks', :to => 'pages#thanks'
  match '/library', :to => 'pages#home'
  match '/search', :to => 'pages#search'
  match '/browse', :to => 'pages#browse'

  match '/mobile', :to => 'pages#index'
  match '/fullsite', :to => 'pages#index'

  root :to => 'pages#index'

end
