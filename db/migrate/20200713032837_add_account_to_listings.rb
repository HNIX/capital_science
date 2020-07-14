class AddAccountToListings < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_reference :listings, :account, null: false, index: {algorithm: :concurrently}
  end
end
