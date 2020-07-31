class AddOwnerReferenceToListings < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
  add_reference :listings, :owner, references: :users, index: {algorithm: :concurrently}
 add_foreign_key :listings, :users, column: :owner_id, validate: false
 # validate_foreign_key :listings, :users

  end
end
