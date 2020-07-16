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
      .permit(:name, :email, Membership::ROLES)
      .merge(listing: @listing, sender: current_user)
  end

  # def require_account_admin
  #   account_user = @account.account_users.find_by(user: current_user)
  #   unless account_user&.active_roles&.include?(:admin)
  #     redirect_to @account, alert: "Only account admins are allowed to do that."
  #   end
  # end
end