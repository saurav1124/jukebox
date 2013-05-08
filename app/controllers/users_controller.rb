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
  
  def search
    search = Sunspot.search(User) do
      fulltext params[:q] + "*"
      # adjust_solr_params do |params|
        # params[:qf] = "title^1.5 category^1.0 keywords^1.0 description^1.0" unless noTermSearch
        # params[:bf] = "recip(ms(NOW,created_at),3.16e-11,1,1)" unless noTermSearch
        # params[:bf] = "recip(geodist(location_ll," + session[:search_loc][:lat].to_s + "," + session[:search_loc][:lng].to_s + "),2,200,20)" unless nonLocBased
        # params[:mm] = 0 unless noTermSearch
      # end
      # with(:location).in_radius(session[:search_loc][:lat].to_f, session[:search_loc][:lng].to_f, params[:distance].to_i) unless nonLocBased
      paginate :page => params[:page], :per_page => 10
      # order_by(:created_at, :desc) if noTermSearch
    end
    @users = search.results
    render "users/search", :layout => false
  end
  
end
