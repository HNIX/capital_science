class BackfillAddPrivateToListings < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def up
    Listing.unscoped.in_batches do |relation| 
      relation.update_all private_listing: false
      sleep(0.01)
    end
  end
end
