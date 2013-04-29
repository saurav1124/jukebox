class UsersController < ApplicationController

  def check_friend_request
    cnt = FriendRequest.where("user_id = ? and status = ?", current_user.id, FriendRequest::STATUS_PENDING).count
    if cnt > 0
      render json: { :count => cnt, :label => cnt.to_s }
    else
      render json: { :count => 0, :label => t("label.zero_no").downcase }
    end
  end
  
  def friend_requests
    @requests = FriendRequest.all( :include => :from_user,
                                   :conditions => ["user_id = ? and status = ?", current_user.id, FriendRequest::STATUS_PENDING],
                                   :order => "friend_requests.created_at" )
    render "users/friend_requests", :layout => false
  end
  
  def accept_friend
    req = FriendRequest.where("invite_token = ?", params[:id]).first
    make_friend(req)
    render json: { :message => t("txt.accept_friend", :name => req.from_user.name) }
  end
  
end
