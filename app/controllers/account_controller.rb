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
    @friends = get_friends(current_user.id)
  end

  def invite_friend
    emails = params[:emails].split(",")
    emails.each do |email|
      user = User.find_by_email(email)
      if user == nil
        pwd = gen_unique_key_for_model(16)
        user = User.new(:name => email.split("@")[0], :email => email, :password => pwd, :password_confirmation => pwd)
        user.save!
        friend_request = FriendRequest.new(:user_id => user.id,
                                           :from_user_id => current_user.id,
                                           :invite_token => gen_unique_key_for_model(16),
                                           :status => FriendRequest::STATUS_PENDING)
        friend_request.save!
        Mailer.invite_friend(current_user, user, friend_request).deliver
      else
        FriendRequest.create(:user_id => user.id,
                             :from_user_id => current_user.id,
                             :invite_token => gen_unique_key_for_model(16),
                             :status => FriendRequest::STATUS_PENDING)
      end
    end
  end
  
private

  def resolve_layout
    "left_nav"
  end

end
