class AddFingerprintToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :fingerprint, :string, :null => false
    add_index :tracks, [:user_id, :fingerprint]
  end
end
