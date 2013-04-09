class AccountController < ApplicationController

  layout :resolve_layout

  before_filter :check_signed_in!
  
  def index
    @user = User.find(current_user.id)
  end

  def password
    @user = User.find(current_user.id)
  end

  def photo
    @user = User.find(current_user.id)
  end

  def friends
    @user = User.find(current_user.id)
  end

private

  def resolve_layout
    "left_nav"
  end

end
