class Track < ActiveRecord::Base
  
  require 'taglib'

  include ModelHelper

  attr_accessible :title, :composer_id, :album_id, :album_index, :track_length,
                  :year, :released_dt, :rating, :media

  has_many        :artists, :class_name => "TrackArtist", :autosave => true
  belongs_to      :album
  belongs_to      :artwork
  
  has_attached_file   :media,
                      :path => APP_CONFIG['media_folder_path'] + "/:hash.:extension",
                      :url => APP_CONFIG['media_base_url'] + "/:hash.:extension",
                      :hash_secret => "airff3kc43kb9dcerl87bvelb7cbwl76rwek",
                      :default_url => APP_CONFIG['cdn_base_url'] + "/images/def_artwork.jpg"

  before_create :set_uqid, :extract_metadata
  after_save    :process_media
  
  searchable :ignore_attribute_changes_of => [
                                              :album_index,
                                              :play_length
                                             ] do
    text      :uqid,                  :as => "uqid"
    text      :url,                   :as => "url"
    text      :title,                 :as => "name"
    text      :index_artist_names,    :as => "artists"
    text      :album_name,            :as => "album_name"
    text      :genre,                 :as => "genre"
    integer   :year,                  :as => "year"
    date      :created_at,            :as => "created_at"
    text      :artwork_url,           :as => "artwork"
  end
  
  def name
    self.title
  end
  
  def artist_name
    self.artists.map( &:name ).join(", ").strip
  end

  def album_name
    self.album.name
  end

  def artwork_url
    self.artwork ? self.artwork.urll : Artwork.new.urll
  end

  def art
    self.artwork ? self.artwork.urll : Artwork.new.urll
  end

  def media_url(type = :mp3)
    media.url
  end

  def process_media
  end

  handle_asynchronously :process_media

  def gen_fingerprint(track)
    fp = track.name + track.album.name + track.attributes["media_content_type"] + track.attributes["media_file_name"] + track.attributes["media_file_size"].to_s
    Base64.encode64(fp)
  end
  
  def extract_metadata
    #return unless audio?
    if media != nil && self.album_id == nil
      path = media.queued_for_write[:original].path
      # artwork
      artwork = Artwork.new
      TagLib::MPEG::File.open(path) do |file|
        tag = file.id3v2_tag
        cover = tag.frame_list('APIC').first
        if cover != nil && cover.picture != nil
          sio = StringIO.new(cover.picture)
          artwork.photo = sio
          artwork.save!
        end
      end
      TagLib::FileRef.open(path) do |fileref|
        tag = fileref.tag
        # Read basic attributes
        # artist
        artist_ids = []
        artist_names = tag.artist
        artist_names.split(/\s*&\s+|\s*,\s*|\s+&\s+|\s+and\s+/).each do |name|
          artist = Artist.where("name = ? and user_id = ?", name.strip, self.user_id).first
          if artist == nil
            artist = Artist.new(:name => name.strip)
            artist.user_id = self.user_id
            artist.save!
          end
          artist_ids << artist.id
        end
        # album
        album_name = tag.album
        if album_name.blank?
          album_name = "Singles"
        else
          album_name = album_name.strip
        end
        album = Album.where("name = ? and user_id = ?", album_name, self.user_id).first
        if album == nil
          album = Album.new(:name => album_name)
          album.user_id = self.user_id
          album.artwork_id = artwork.id
          album.save!
        end
        artist_ids.each do |artist_id|
          aa = AlbumArtist.where("album_id = ? and artist_id = ?", album.id, artist_id).first
          if aa == nil
            aa = AlbumArtist.new(:album_id => album.id, :artist_id => artist_id)
            aa.save!
          end
        end
        # track
        self.title = tag.title
        self.album_id = album.id
        self.year = tag.year.to_i
        self.track_no = tag.track.to_i
        self.genre = tag.genre
        self.artwork_id = artwork.id
        self.fingerprint = gen_fingerprint(self)
        #tag.comment
        properties = fileref.audio_properties
        self.track_length = properties.length
        self.artists = []
        self.rating = 0
        artist_ids.each do |artist_id|
          aa = TrackArtist.new(:artist_id => artist_id)
          aa.user_id = self.user_id
          self.artists << aa
        end
      end
    end
  end

private

  def set_uqid
    self.uqid = gen_unique_key_for_model(16)
    self.url = "/t/" + self.uqid
  end

  def index_artist_names
    self.artists.map( &:name )
  end
  
  def audio?
    media_content_type =~ %r{^audio/(?:mp3|mpeg|mpeg3|mpg|x-mp3|x-mpeg|x-mpeg3|x-mpegaudio|x-mpg|m4a|MP4A)$}
  end

end
