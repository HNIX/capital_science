class ListingInvitationsController < ApplicationController
	before_action :set_listing_invitation
    before_action :authenticate_user_with_invite!

     def show
	    @listing = @listing_invitation.listing
	    @invited_by = @listing_invitation.sender
	 end

	  def update
	    if @listing_invitation.accept!(current_user)
	      redirect_to listings_path
	    else
	      message = @listing_invitation.errors.full_messages.first || "Something went wrong"
	      redirect_to listing_invitation_path(@listing_invitation), alert: message
	    end
	  end

	  def destroy
	    @listing_invitation.reject!
	    redirect_to root_path
	  end
	
    private

	  def set_listing_invitation
	    @listing_invitation = ListingInvitation.find_by!(token: params[:id])
	  rescue ActiveRecord::RecordNotFound
	    redirect_to root_path, alert: "Whoops, we weren't able to find this invitation. Check with your account admin for a new invitation."
	  end


	  def authenticate_user_with_invite!
	    unless user_signed_in?
	      store_location_for(:user, request.fullpath)
	      redirect_to new_user_registration_path(invite: @listing_invitation.token), alert: "Please login or create an account to accept this invitation"
	    end
	  end
end






 

  