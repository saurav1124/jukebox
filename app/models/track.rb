class Track < ActiveRecord::Base

  include ModelHelper

  attr_accessible :title, :artist_id, :album_id, :album_index, :play_length,
                  :released_d, :released_m, :released_y, :released_dt,
                  :rating

  belongs_to      :artist
  belongs_to      :album
  belongs_to      :artwork

  before_create :set_uqid

  searchable :ignore_attribute_changes_of => [
                                              :album_index,
                                              :play_length
                                             ] do
    text      :title,             :as => "name"
    text      :artist_name,       :as => "artist_name"
    text      :album_name,        :as => "album_name"
    text      :genre,             :as => "genre"
    integer   :released_y,        :as => "year"
    date      :created_at,        :as => "created_at"
    text      :artwork_url,       :as => "artwork"
  end
  
  def artist_name
    self.artist.name
  end

  def artist_artwork
    self.artist.artwork
  end

  def album_name
    self.album.name
  end

  def album_artwork
    self.album.artwork
  end

  def artwork_url
    self.artwork ? self.artwork.urll : ""
  end

private

  def set_uqid
    self.uqid = gen_unique_key_for_model(16)
    self.url = "/t/" + self.uqid
  end

end
