class Listings::ListingInvitationsController < ApplicationController
  before_action :set_listing
  # before_action :require_account_admin
  before_action :set_listing_invitation, only: [:edit, :update, :destroy]

  def new
    @listing_invitation = ListingInvitation.new
  end

  def create    
    @listing_invitation = ListingInvitation.new(invitation_params)
    if @listing_invitation.save_and_send_invite
      redirect_to @listing
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @listing_invitation.update(invitation_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    @listing_invitation.destroy
    redirect_to @listing
  end

  def create_batch 
    contact_ids = params[:listing_invitation][:contact_ids].reject! { |c| c.empty? }

    contact_ids.each do |id|
      contact = Contact.find(id)
      
      invitation = ListingInvitation.new(name:contact.first_name, email:contact.email, sender: current_user, listing: @listing, contact_ids: contact.id)

      invitation.save_and_send_invite
    end
    
    redirect_to listing_memberships_url
  end
  
  private

  def set_listing
    @listing = current_account.listings.find(params[:listing_id])
  end

  def set_listing_invitation
    @listing_invitation = @listing.listing_invitations.find_by!(token: params[:id])
  end

  def invitation_params
    params
      .require(:listing_invitation)
      .permit(contact_ids: [])
      .merge(listing: @listing, sender: current_user)
  end

  # def require_account_admin
  #   account_user = @account.account_users.find_by(user: current_user)
  #   unless account_user&.active_roles&.include?(:admin)
  #     redirect_to @account, alert: "Only account admins are allowed to do that."
  #   end
  # end
end