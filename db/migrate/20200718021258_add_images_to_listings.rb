class AddImagesToListings < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
    add_reference :listing_images, :listing, null: false, index: {algorithm: :concurrently}
  end
end
