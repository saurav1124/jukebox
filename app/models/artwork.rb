class Artwork < ActiveRecord::Base

  attr_accessible   :photo

  has_attached_file :photo, :styles => { :s => ["64x64>", :jpg],
                                         :m => ["128x128>", :jpg],
                                         :l => ["300x300>", :jpg],
                                         :x => ["640x640>", :jpg]
                                       },
                            :path => APP_CONFIG['artwork_folder_path'] + "/:hash-:style.:extension",
                            :url => APP_CONFIG['artwork_base_url'] + "/:hash-:style.:extension",
                            :hash_secret => "airff3kc43kb9dcerl87bvelb7cbwl76rwek",
                            :default_url => APP_CONFIG['cdn_base_url'] + "/images/def_artwork.jpg"

  validates_attachment_size :photo, :less_than => 500.kilobytes,
                            :message => I18n.t("errors.photo_too_large", :size => "500KB")
  validates_attachment_content_type :photo, 
                                    :content_type => [
                                      'image/jpeg',
                                      'image/png',
                                      'image/gif',
                                      'image/pjpeg',
                                      'image/x-png',
                                      'text/plain'
                                     ],
                            :message => I18n.t("errors.file_invalid_format", :formats => "JPG,GIF,PNG")

  def urls
    photo.url(:s)
  end

  def urlm
    photo.url(:m)
  end

  def urll
    photo.url(:l)
  end

  def urlx
    photo.url(:x)
  end

end
