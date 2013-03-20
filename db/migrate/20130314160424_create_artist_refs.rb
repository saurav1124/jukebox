class CreateArtistRefs < ActiveRecord::Migration

  def change

    remove_column :albums, :artist_id
    add_column :albums, :composer_id, :integer, :null => true
    create_table :album_artists do |t|
      t.integer       :album_id,    :null => false
      t.integer       :artist_id,   :null => false
      t.timestamps
    end
    add_index :album_artists, [:album_id]
    add_index :album_artists, [:artist_id]
    add_index :album_artists, [:album_id, :artist_id], :unique => true

    remove_column :tracks, :artist_id
    create_table :track_artists do |t|
      t.integer       :track_id,    :null => false
      t.integer       :artist_id,   :null => false
      t.timestamps
    end
    add_index :track_artists, [:track_id]
    add_index :track_artists, [:artist_id]
    add_index :track_artists, [:track_id, :artist_id], :unique => true

  end

end
