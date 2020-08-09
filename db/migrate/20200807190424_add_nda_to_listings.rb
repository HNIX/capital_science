class AddNdaToListings < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_reference :listings, :nda, index: {algorithm: :concurrently}
  end
end
