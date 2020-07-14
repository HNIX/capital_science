class RemoveColumnDraftFromListings < ActiveRecord::Migration[6.0]
  def change
  	safety_assured { remove_column :listings, :draft }
  end
end
