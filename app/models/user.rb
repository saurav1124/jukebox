class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_attached_file :photo, :styles => { :s => ["80x80#", :png], :m => ["200x200#", :png], :l => ["800x600>", :png] },
                            :path => APP_CONFIG['photos_folder_path'] + "/:hash-:style.:extension",
                            :url => APP_CONFIG['photos_base_url'] + "/:hash-:style.:extension",
                            :hash_secret => "airff3kc43kb9dcerl87bvelb7cbwl76rwek",
                            :default_url => APP_CONFIG['cdn_base_url'] + "/images/def_user.png"

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

  after_create    :add_default_playlists
  
  DEFAULT_PLAYLISTS = [
    ["favorites", 12, Playlist::TYPE_FAVORITE],
    ["recently_played", 24, Playlist::TYPE_RECENT_PLAYED],
    ["most_played", 28, Playlist::TYPE_MOST_PLAYED],
    ["friends_listening", 36, Playlist::TYPE_FRIENDS_PLAYED]
  ]
  
  searchable :ignore_attribute_changes_of => [] do
    text      :name,                  :as => "name"
    date      :created_at,            :as => "created_at"
  end

  def display_name
    self.name
  end

private

  def add_default_playlists
    DEFAULT_PLAYLISTS.each do |list|
      Playlist.create(:name => "playlists." + list[0], :user_id => self.id, :order_no => list[1].to_i, :personal => true, :list_type => list[2].to_i)
    end
  end

end
