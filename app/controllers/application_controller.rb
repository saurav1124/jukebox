class ApplicationController < ActionController::Base

  include ApplicationHelper
  include ModelHelper
  include UsersHelper

  protect_from_forgery

  layout :resolve_layout

  before_filter :pre_request

  def store_location
    session[:user_return_to] = request.url unless params[:controller] == "devise/sessions"
  end

  def after_sign_in_path_for(resource)
    library_path
  end

protected

  def set_top_flash(msg)
    flash[:top_flash] = msg
  end

private

  def resolve_layout
    return "page"
  end

  def check_signed_in!
    if !user_signed_in?
      store_location
      redirect_to new_user_session_path
    end
  end

  def pre_request
  end

end
