class Artist < ActiveRecord::Base

  attr_accessible :name

  include ModelHelper

  belongs_to     :artwork

  before_create :set_uqid

  def artwork_url
    self.artwork ? self.artwork.urll : APP_CONFIG['cdn_base_url'] + "/images/def_user.png"
  end

private

  def set_uqid
    self.uqid = gen_unique_key_for_model(16)
    self.url = "/ar/" + self.uqid
  end

end
