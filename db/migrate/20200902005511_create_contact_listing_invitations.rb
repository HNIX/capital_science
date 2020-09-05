class CreateContactListingInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_listing_invitations do |t|
      t.references :listing_invitation, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true
    end
  end
end
