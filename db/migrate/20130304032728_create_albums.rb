class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string        :name,                  :null => false, :limit => 512
      t.string        :uqid,                  :null => false, :limit => 128
      t.string        :url,                   :null => false, :limit => 256
      t.integer       :artist_id,             :null => true
      t.integer       :track_count,           :null => false, :default => 0
      t.string        :genre,                 :null => true
      t.float         :play_length,           :null => false, :default => 0
      t.integer       :released_d,            :null => true
      t.integer       :released_m,            :null => true
      t.integer       :released_y,            :null => true
      t.timestamps
    end
    add_index   :albums, [:name]
    add_index   :albums, [:uqid]
    add_index   :albums, [:url]
    add_index   :albums, [:artist_id, :name]
  end
end
