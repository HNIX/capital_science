class AddUserToListingImages < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
    add_reference :listing_images, :user, null: false, index: {algorithm: :concurrently}
  end
end
