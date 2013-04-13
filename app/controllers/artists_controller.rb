class ArtistsController < ApplicationController

  layout :resolve_layout

  before_filter :check_signed_in!

  def index
    @tmenu = "artists"
    @artists = Artist.where("user_id = ?", current_user.id).order("name")
    @artists_ordered = TrackArtist.all(:select => "count(*) track_count, artist_id",
                                      :conditions => ["user_id = ? ", current_user.id],
                                      :group => "artist_id",
                                      :order => "track_count desc",
                                      :limit => 10)
    if request.headers["top-menu"]
      render "artists/index", :layout => "left_nav_partial"
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @artists }
      end
    end
  end

  def tracks
    if params[:uqid].present?
      @artist = Artist.find_by_uqid(params[:uqid])
    else
      @artist = Artist.find_by_uqid(params[:id])
    end
    tracks = TrackArtist.where("artist_id = ?", @artist.id)
    @tracks = tracks.map(&:track)
    render "artists/tracks", :layout => false
  end

private

  def resolve_layout
    return "left_nav"
  end

end
