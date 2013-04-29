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
    @albums = Album.all(
      :include => ["artwork", "tracks", "artists"],
      :conditions => ["albums.user_id = ?", current_user.id],
      :order => "albums.name"
    )
    @tracks = Track.where("user_id = ?", current_user.id).order("play_count desc")
    if request.headers["top-menu"]
      render "tracks/index", :layout => false
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @tracks }
      end
    end
  end
  
  def upload
    @track = Track.new
    render "tracks/upload", :layout => "blank"
  end
  
  def import
    @track = Track.new(params[:track])
    @track.ectract_metadata
    fp = @track.gen_fingerprint
    @db_track = Track.where("user_id = ? and fingerprint = ?", current_user.id, fp)
    saved = false
    if track != nil
      saved = @db_track.update_attributes(params[:track])
    else
      saved = @track.save
    end
    @track.user_id = current_user.id
    if saved
      json_data = {
        "name" => @track.attributes[:media_file_name],
        "size" => @track.attributes[:media_file_size],
        "url" => @track.media.url(:original),
        "delete_url" => track_path(@track),
        "delete_type" => "DELETE" 
      }
      render json: json_data
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

private

  def resolve_layout
    return "page"
  end

end
