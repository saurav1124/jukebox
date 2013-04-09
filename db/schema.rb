# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130329142454) do

  create_table "album_artists", :force => true do |t|
    t.integer  "album_id",   :null => false
    t.integer  "artist_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "album_artists", ["album_id", "artist_id"], :name => "index_album_artists_on_album_id_and_artist_id", :unique => true
  add_index "album_artists", ["album_id"], :name => "index_album_artists_on_album_id"
  add_index "album_artists", ["artist_id"], :name => "index_album_artists_on_artist_id"

  create_table "albums", :force => true do |t|
    t.string   "name",           :limit => 512,                  :null => false
    t.string   "url",            :limit => 256,                  :null => false
    t.integer  "track_count",                   :default => 0,   :null => false
    t.string   "genre"
    t.float    "play_length",                   :default => 0.0, :null => false
    t.integer  "released_d"
    t.integer  "released_m"
    t.integer  "released_y"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "uqid",           :limit => 128,                  :null => false
    t.integer  "composer_id"
    t.integer  "artwork_id"
    t.integer  "user_id",                                        :null => false
    t.datetime "last_played_at"
  end

  add_index "albums", ["last_played_at"], :name => "index_albums_on_last_played_at"
  add_index "albums", ["name"], :name => "index_albums_on_artist_id_and_name", :length => {"name"=>255}
  add_index "albums", ["name"], :name => "index_albums_on_name", :length => {"name"=>255}
  add_index "albums", ["uqid"], :name => "index_albums_on_uqid", :unique => true
  add_index "albums", ["url"], :name => "index_albums_on_url", :length => {"url"=>255}
  add_index "albums", ["user_id"], :name => "index_albums_on_user_id"

  create_table "artist_members", :force => true do |t|
    t.integer  "group_id",   :null => false
    t.integer  "artist_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "artists", :force => true do |t|
    t.string   "name",       :limit => 512, :null => false
    t.string   "url",        :limit => 256, :null => false
    t.integer  "artwork_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "uqid",       :limit => 128, :null => false
  end

  add_index "artists", ["name"], :name => "index_artists_on_name", :length => {"name"=>255}
  add_index "artists", ["uqid"], :name => "index_artists_on_uqid", :unique => true
  add_index "artists", ["url"], :name => "index_artists_on_url", :length => {"url"=>255}

  create_table "artworks", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "artwork_data"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "playlist_tracks", :force => true do |t|
    t.integer  "playlist_id", :null => false
    t.integer  "track_id",    :null => false
    t.integer  "order_no",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "playlist_tracks", ["playlist_id", "order_no"], :name => "index_playlist_tracks_on_playlist_id_and_order_no", :unique => true
  add_index "playlist_tracks", ["playlist_id", "track_id"], :name => "index_playlist_tracks_on_playlist_id_and_track_id", :unique => true
  add_index "playlist_tracks", ["playlist_id"], :name => "index_playlist_tracks_on_playlist_id"

  create_table "playlists", :force => true do |t|
    t.string   "name",       :limit => 32,                     :null => false
    t.integer  "user_id",                                      :null => false
    t.integer  "order_no",                                     :null => false
    t.boolean  "personal",                  :default => true,  :null => false
    t.boolean  "syslist",                   :default => false, :null => false
    t.string   "uqid",       :limit => 128,                    :null => false
    t.string   "url",        :limit => 256,                    :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "playlists", ["name"], :name => "index_playlists_on_name"
  add_index "playlists", ["user_id", "name"], :name => "index_playlists_on_user_id_and_name", :unique => true
  add_index "playlists", ["user_id", "personal"], :name => "index_playlists_on_user_id_and_personal"
  add_index "playlists", ["user_id", "syslist", "order_no"], :name => "index_playlists_on_user_id_and_syslist_and_order_no", :unique => true
  add_index "playlists", ["user_id", "syslist"], :name => "index_playlists_on_user_id_and_syslist"
  add_index "playlists", ["user_id"], :name => "index_playlists_on_user_id"

  create_table "track_artists", :force => true do |t|
    t.integer  "track_id",   :null => false
    t.integer  "artist_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "track_artists", ["artist_id"], :name => "index_track_artists_on_artist_id"
  add_index "track_artists", ["track_id", "artist_id"], :name => "index_track_artists_on_track_id_and_artist_id", :unique => true
  add_index "track_artists", ["track_id"], :name => "index_track_artists_on_track_id"

  create_table "tracks", :force => true do |t|
    t.string   "title",              :limit => 512,                :null => false
    t.string   "url",                :limit => 256,                :null => false
    t.integer  "album_id"
    t.integer  "album_index",                       :default => 1, :null => false
    t.datetime "release_dt"
    t.float    "rating",                                           :null => false
    t.integer  "artwork_id"
    t.string   "genre"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "uqid",               :limit => 128,                :null => false
    t.integer  "year"
    t.integer  "track_no"
    t.integer  "track_length"
    t.integer  "composer_id"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.integer  "user_id",                                          :null => false
    t.datetime "last_played_at"
    t.integer  "play_count",                        :default => 0, :null => false
  end

  add_index "tracks", ["album_id", "album_index"], :name => "index_tracks_on_album_id_and_album_index"
  add_index "tracks", ["album_id", "title"], :name => "index_tracks_on_album_id_and_title", :length => {"album_id"=>nil, "title"=>255}
  add_index "tracks", ["album_id", "track_no"], :name => "index_tracks_on_album_id_and_track_no"
  add_index "tracks", ["album_id"], :name => "index_tracks_on_album_id_and_track_length"
  add_index "tracks", ["last_played_at"], :name => "index_tracks_on_last_played_at"
  add_index "tracks", ["play_count"], :name => "index_tracks_on_play_count"
  add_index "tracks", ["title"], :name => "index_tracks_on_artist_id_and_title", :length => {"title"=>255}
  add_index "tracks", ["title"], :name => "index_tracks_on_title", :length => {"title"=>255}
  add_index "tracks", ["uqid"], :name => "index_tracks_on_uqid", :unique => true
  add_index "tracks", ["url"], :name => "index_tracks_on_url", :length => {"url"=>255}
  add_index "tracks", ["user_id"], :name => "index_tracks_on_user_id"

  create_table "user_tracks", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "track_id",                      :null => false
    t.integer  "play_count",     :default => 0, :null => false
    t.integer  "last_played_at", :default => 0, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "user_tracks", ["user_id", "play_count"], :name => "index_user_tracks_on_user_id_and_play_count"
  add_index "user_tracks", ["user_id", "track_id"], :name => "index_user_tracks_on_user_id_and_track_id", :unique => true
  add_index "user_tracks", ["user_id"], :name => "index_user_tracks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                                 :null => false
    t.string   "nickname",               :limit => 32
    t.date     "dob"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
