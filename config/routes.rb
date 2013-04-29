Jukebox::Application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => "users/registrations" } do
    get 'signout' => 'devise/sessions#destroy'
  end

  match '/accept_friend', :to => 'users#accept_friend'
  match '/accept_friend/:id', :to => 'users#accept_friend'

  resources :users do
    collection do
      get :friend_requests
      get :check_friend_request
    end
    member do
    end
  end

  resources :releases

  resources :artist_members

  resources :artists do
    member do
      get   :tracks
    end
  end

  resources :tracks, :path => "songs" do
    collection do
      get   :upload
      post  :import
    end
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
  match '/account/invite_friend', :to => 'account#invite_friend'

  match '/request_invite', :to => "pages#request_invite"
  match '/accept_invite', :to => "pages#accept_invite"
  match '/accept_invite/:token', :to => "pages#accept_invite"
  match '/home', :to => 'pages#home'
  match '/thanks', :to => 'pages#thanks'
  match '/library', :to => 'pages#home'
  match '/search', :to => 'pages#search'
  match '/browse', :to => 'pages#browse'

  match '/mobile', :to => 'pages#index'
  match '/fullsite', :to => 'pages#index'

  root :to => 'pages#index'

end
