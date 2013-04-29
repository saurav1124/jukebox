class Album < ActiveRecord::Base

  attr_accessible :name, :composer_id

  include ModelHelper

  belongs_to      :artwork
  has_many        :artists, :class_name => "AlbumArtist"
  has_many        :tracks, :order => :track_no
  
  before_create :set_uqid
  
  def to_param
    "#{url}"
  end

  def artwork_url
    self.artwork ? self.artwork.urll : Artwork.new.urll
  end

  def artist_name
    artists.count > 1 ? I18n.t("label.various_artists") : artists[0].name
  end

  def artist_names
    self.artists.map( &:name ).join(", ").strip
  end

private

  def set_uqid
    self.uqid = gen_unique_key_for_model(16)
    self.url = good_url(self.name) + "/" + self.uqid
  end

end
