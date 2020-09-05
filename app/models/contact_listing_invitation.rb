# == Schema Information
#
# Table name: contact_listing_invitations
#
#  id                    :bigint           not null, primary key
#  contact_id            :bigint           not null
#  listing_invitation_id :bigint           not null
#
# Indexes
#
#  index_contact_listing_invitations_on_contact_id             (contact_id)
#  index_contact_listing_invitations_on_listing_invitation_id  (listing_invitation_id)
#
# Foreign Keys
#
#  fk_rails_...  (contact_id => contacts.id)
#  fk_rails_...  (listing_invitation_id => listing_invitations.id)
#
class ContactListingInvitation < ApplicationRecord
  belongs_to :listing_invitation
  belongs_to :contact
end
