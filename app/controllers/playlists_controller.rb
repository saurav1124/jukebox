class PlaylistsController < ApplicationController
  
  include PlaylistsHelper

  layout :resolve_layout
  
  before_filter :check_signed_in!
  
  def add_track
    # TODO: check playlist can edit
    track = Track.find_by_uqid(params[:trkid])
    playlist = Playlist.find(params[:id])
    pl_track = PlaylistTrack.where("playlist_id = ? and track_id = ?", params[:id], track.id).first
    max_plt = PlaylistTrack.where("playlist_id = ?", params[:id]).order("order_no desc").first
    order_no = 1 if max_plt == nil
    order_no = max_plt.order_no + 1 if max_plt != nil
    if pl_track == nil
      pl_track = PlaylistTrack.new
      pl_track.playlist_id = params[:id]
      pl_track.track_id = track.id
      pl_track.order_no = order_no
      pl_track.save!
    end
    render json: { status: 200, :message => t("txt.trk_added_pl", :track => track.title, :playlist => playlist.display_name)}
  end
  
  def remove_track
    # TODO: check playlist can edit
    playlist = Playlist.find_by_uqid(params[:id])
    track = Track.find_by_uqid(params[:trkid])
    if playlist != nil && track != nil && can_edit_playlist(playlist)
      pl_track = PlaylistTrack.where("playlist_id = ? and track_id = ?", playlist.id, track.id).first
      pl_track.destroy
    end
    render json: { :status => 200, :message => "deleted" }
  end

  def add_album
    
  end
  
  def tracks
    if params[:uqid].present?
      @playlist = Playlist.find_by_uqid(params[:uqid])
    else
      @playlist = Playlist.find_by_uqid(params[:id])
    end
    render "playlists/tracks", :layout => false
  end

  def index
    @playlists = Playlist.where("user_id = ?", current_user.id).order("order_no")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlists }
    end
  end

private

  def resolve_layout
    return "left_nav"
  end

end
