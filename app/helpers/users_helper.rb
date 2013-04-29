module UsersHelper

  def my_playlists
    Playlist.where("user_id = ? and list_type in (?)", current_user.id, Playlist::ADDABLE_LISTS).order("list_type, order_no").limit(10)
  end

  def my_albums
    Album.limit(10)
  end
  
  def my_tracks
    Track.limit(40)
  end

  def my_friend_requests
    FriendRequest.where("status = ?", FriendRequest::STATUS_PENDING).order("created_at desc")
  end

  def get_friends(user_id)
    Friend.all(
      :include => ["user"],
      :conditions => ["me_id = ?", user_id],
      :order => "users.name"
    )
  end
  
  def make_friend(req)
    Friend.create(:me_id => current_user.id, :user_id => req.from_user_id, :status => FriendRequest::STATUS_ACCEPTED)
    Friend.create(:me_id => req.from_user_id, :user_id => current_user.id, :status => FriendRequest::STATUS_ACCEPTED)
    req.destroy
  end

end
