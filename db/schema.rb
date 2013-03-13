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

ActiveRecord::Schema.define(:version => 20130312180643) do

  create_table "albums", :force => true do |t|
    t.string   "name",        :limit => 512,                  :null => false
    t.string   "url",         :limit => 256,                  :null => false
    t.integer  "artist_id"
    t.integer  "track_count",                :default => 0,   :null => false
    t.string   "genre"
    t.float    "play_length",                :default => 0.0, :null => false
    t.integer  "released_d"
    t.integer  "released_m"
    t.integer  "released_y"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "uqid",        :limit => 128,                  :null => false
  end

  add_index "albums", ["artist_id", "name"], :name => "index_albums_on_artist_id_and_name", :length => {"artist_id"=>nil, "name"=>255}
  add_index "albums", ["name"], :name => "index_albums_on_name", :length => {"name"=>255}
  add_index "albums", ["uqid"], :name => "index_albums_on_uqid", :unique => true
  add_index "albums", ["url"], :name => "index_albums_on_url", :length => {"url"=>255}

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

  create_table "tracks", :force => true do |t|
    t.string   "title",        :limit => 512,                :null => false
    t.string   "url",          :limit => 256,                :null => false
    t.integer  "artist_id"
    t.integer  "album_id"
    t.integer  "album_index",                 :default => 1, :null => false
    t.datetime "release_dt"
    t.float    "rating",                                     :null => false
    t.integer  "artwork_id"
    t.string   "genre"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "uqid",         :limit => 128,                :null => false
    t.integer  "year"
    t.integer  "track_no"
    t.integer  "track_length"
    t.integer  "composer_id"
  end

  add_index "tracks", ["album_id", "album_index"], :name => "index_tracks_on_album_id_and_album_index"
  add_index "tracks", ["album_id", "title"], :name => "index_tracks_on_album_id_and_title", :length => {"album_id"=>nil, "title"=>255}
  add_index "tracks", ["album_id", "track_no"], :name => "index_tracks_on_album_id_and_track_no"
  add_index "tracks", ["album_id"], :name => "index_tracks_on_album_id_and_track_length"
  add_index "tracks", ["artist_id", "title"], :name => "index_tracks_on_artist_id_and_title", :length => {"artist_id"=>nil, "title"=>255}
  add_index "tracks", ["title"], :name => "index_tracks_on_title", :length => {"title"=>255}
  add_index "tracks", ["uqid"], :name => "index_tracks_on_uqid", :unique => true
  add_index "tracks", ["url"], :name => "index_tracks_on_url", :length => {"url"=>255}

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
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
