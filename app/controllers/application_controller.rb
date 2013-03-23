class ApplicationController < ActionController::Base

  protect_from_forgery

  layout :resolve_layout

  before_filter :pre_request

  def after_sign_in_path_for(resource)
    home_path
  end

private

  def resolve_layout
    return "main"
  end

  def pre_request
    
  end

end
