class AddStateToListings < ActiveRecord::Migration[6.0]
  def up
    add_column :listings, :draft, :boolean
    add_column :listings, :private, :boolean, null: false
    change_column_default :listings, :draft, true
  end

  def down
    remove_column :listings, :draft
    remove_column :listings, :private
  end
end