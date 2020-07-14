class AddPrivateToListings < ActiveRecord::Migration[6.0]
  def up
    add_column :listings, :private_listing, :boolean
    change_column_default :listings, :private_listing, false
  end

  def down
    remove_column :listings, :private_listing
  end
end
