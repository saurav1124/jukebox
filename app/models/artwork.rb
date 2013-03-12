class Artwork < ActiveRecord::Base

  # attr_accessible :title, :body

  validates_attachment_size :photo, :less_than => 500.kilobytes,
                            :message => I18n.t("errors.photo_too_large", :size => "500KB")
  validates_attachment_content_type :photo, 
                                    :content_type => [
                                      'image/jpeg',
                                      'image/png',
                                      'image/gif',
                                      'image/pjpeg',
                                      'image/x-png'
                                     ],
                            :message => I18n.t("errors.file_invalid_format", :formats => "JPG,GIF,PNG")

  has_attached_file :photo, :styles => { :s => ["64x64>", :jpg],
                                         :m => ["128x128>", :jpg],
                                         :l => ["256x256>", :jpg],
                                         :x => ["512x512>", :jpg]
                                       },
                            :path => APP_CONFIG['cdn_photos_folder_path'] + "/:id/:hash-:style.:extension",
                            :url => APP_CONFIG['cdn_photos_base_url'] + "/:id/:hash-:style.:extension",
                            :hash_secret => "adujbeyevrjdnnufcwerfjfjfsdjhs447dck",
                            :default_url => APP_CONFIG['cdn_base_url'] + "/images/user_default_photo_:style.jpg"


  def urls
    photo ? photo.url(:s) : ""
  end

  def urlm
    photo ? photo.url(:m) : ""
  end

  def urll
    photo ? photo.url(:l) : ""
  end

  def urlx
    photo ? photo.url(:x) : ""
  end

end
