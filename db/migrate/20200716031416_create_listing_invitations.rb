class CreateListingInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_invitations do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: {to_table: :users}
      t.references :recipient, null: false, foreign_key: {to_table: :users}

      t.string :email 
      t.string :token

      t.timestamps
    end
  end
end
