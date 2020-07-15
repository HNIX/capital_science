class AddTimestampsToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :active_at, :datetime
    add_column :listings, :inactive_at, :datetime
    add_column :listings, :closed_at, :datetime
  end
end
