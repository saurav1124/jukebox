class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  after_create    :add_default_playlists

  DEFAULT_PLAYLISTS = [
    ["favorites", 12],
    ["jukebox", 24]
  ]

private

  def add_default_playlists
    DEFAULT_PLAYLISTS.each do |list|
      Playlist.create(:name => "playlists." + list[0], :user_id => self.id, :order_no => list[1].to_i, :personal => true, :syslist => true)
    end
  end

end
