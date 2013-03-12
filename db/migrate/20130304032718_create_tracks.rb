class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string        :title,                 :null => false, :limit => 512
      t.string        :uqid,                  :null => false, :limit => 128
      t.string        :url,                   :null => false, :limit => 256
      t.integer       :artist_id,             :null => true
      t.integer       :album_id,              :null => true
      t.integer       :album_index,           :null => false, :default => 1
      t.float         :play_length,           :null => false
      t.integer       :released_d,            :null => true
      t.integer       :released_m,            :null => true
      t.integer       :released_y,            :null => true
      t.datetime      :release_dt,            :null => true
      t.float         :rating,                :null => false
      t.integer       :artwork_id,            :null => true
      t.string        :genre,                 :null => true
      t.timestamps
    end
    add_index   :tracks, [:title]
    add_index   :tracks, [:uqid]
    add_index   :tracks, [:url]
    add_index   :tracks, [:artist_id, :title]
    add_index   :tracks, [:album_id, :title]
    add_index   :tracks, [:album_id, :album_index]
  end
end
