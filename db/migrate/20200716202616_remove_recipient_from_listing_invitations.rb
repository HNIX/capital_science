class RemoveRecipientFromListingInvitations < ActiveRecord::Migration[6.0]
  def change
  	safety_assured { remove_column :listing_invitations, :recipient_id }
  end
end
