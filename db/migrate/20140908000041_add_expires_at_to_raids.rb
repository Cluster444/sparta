class AddExpiresAtToRaids < ActiveRecord::Migration
  def change
    add_column :raids, :expires_at, :datetime
  end
end
