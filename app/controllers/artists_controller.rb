class ArtistsController < ApplicationController

  layout :resolve_layout

  before_filter :check_signed_in!

  def index
    @tmenu = "artists"
    @artists = Artist.order("name")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
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
