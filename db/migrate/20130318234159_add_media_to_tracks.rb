class AddMediaToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :media_file_name,     :string,      :null => true
    add_column :tracks, :media_content_type,  :string,      :null => true
    add_column :tracks, :media_file_size,     :integer,     :null => true
    add_column :tracks, :media_updated_at,    :datetime,    :null => true
  end
end
