class AddFieldsToListingInvitation < ActiveRecord::Migration[6.0]
  def change
    add_column :listing_invitations, :name, :string
    add_column :listing_invitations, :roles, :jsonb
  end
end
