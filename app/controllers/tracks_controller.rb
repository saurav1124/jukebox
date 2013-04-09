class TracksController < ApplicationController

  layout :resolve_layout
  
  before_filter :check_signed_in!
  
  def details
    @track = Track.find_by_uqid(params[:id])
    data = {
      :title => @track.title,
      :album => @track.album_name,
      :artist => @track.artist_name,
      :artwork => {
        :url => @track.artwork_url
      },
      :media => {
        :mp3 => @track.media_url
      }
    }
    @track.play_count = @track.play_count + 1
    @track.last_played_at = DateTime.now
    data[:play_count] = @track.play_count
    @track.save!
    track_count = UserTrack.where("user_id = ? and track_id = ?", current_user.id, @track.id).first
    if track_count == nil
      track_count = UserTrack.new
      track_count.user_id = current_user.id
      track_count.track_id = @track.id
      track_count.play_count = 1
      track_count.last_played_at = DateTime.now
    else
      track_count.play_count = track_count.play_count + 1
      track_count.last_played_at = DateTime.now
    end
    track_count.save!
    render json: data
  end

  def index
    @tmenu = "tracks"
    @tracks = Track.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tracks }
    end
  end

private

  def resolve_layout
    return "page"
  end

end
