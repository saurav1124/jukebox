class ChangeTracks1 < ActiveRecord::Migration
  def up

    remove_column :tracks, :play_length
    remove_column :tracks, :released_d
    remove_column :tracks, :released_m
    remove_column :tracks, :released_y

    add_column    :tracks, :year,         :integer, :null => true
    add_column    :tracks, :track_no,     :integer, :null => true
    add_column    :tracks, :track_length, :integer, :null => true
    add_column    :tracks, :composer_id,  :integer, :null => true

    add_index   :tracks, [:album_id, :track_no]

    add_column    :artworks, :artwork_data, :text,    :null => true

  end

  def down

    remove_index  :tracks, [:album_id, :track_no]

    remove_column :tracks, :year
    remove_column :tracks, :track_no
    remove_column :tracks, :track_length
    remove_column :tracks, :composer_id

    add_column    :tracks, :play_length, :float,    :null => true
    add_column    :tracks, :released_d,  :integer,  :null => true
    add_column    :tracks, :released_m,  :integer,  :null => true
    add_column    :tracks, :released_y,  :integer,  :null => true

    remove_column :artworks, :artwork_data

  end

end
