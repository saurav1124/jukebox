class Users::RegistrationsController < Devise::RegistrationsController

  include UsersHelper

  layout :resolve_layout

  def new
    if session[:fr_token]
      @friend_request = FriendRequest.where("invite_token = ?", session[:fr_token]).first
      @email = @friend_request.user.email
    end
  end
  
  def create
    if session[:fr_token]
      req = FriendRequest.where("invite_token = ?", session[:fr_token]).first
      user = req.user
      user.name = params[:user][:name]
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      user.save!
      sign_in(resource_name, user)
      make_friend(req)
      flash[:top_flash] = t("txt.welcome_accept_friend", :name => req.from_user.name)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      super
    end
  end
  
private

  def resolve_layout
      "page"
  end
  
end