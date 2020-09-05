class ContactListingInvitationsController < ApplicationController
  def create
    @contact = Contact.find(params[:contact_id])
    @listing_invitation = ListingInvitation.find(params[:listing_invitation_id])
    @contact.listing_invitations << @listing_invitation
  end
end