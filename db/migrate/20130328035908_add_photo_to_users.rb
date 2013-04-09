class AddPhotoToUsers < ActiveRecord::Migration

  def change
    add_column :users, :photo_file_name,     :string,      :null => true
    add_column :users, :photo_content_type,  :string,      :null => true
    add_column :users, :photo_file_size,     :integer,     :null => true
    add_column :users, :photo_updated_at,    :datetime,    :null => true
  end

end
