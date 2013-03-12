class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string        :photo_file_name,     :null => true
      t.string        :photo_content_type,  :null => true
      t.integer       :photo_file_size,     :null => true
      t.datetime      :photo_updated_at,    :null => true
      t.timestamps
    end
  end
end
