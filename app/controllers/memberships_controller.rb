class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing
  before_action :set_membershipr, only: [:edit, :update, :destroy, :switch]
  # before_action :require_admin, except: [:index, :show]

  # GET /accounts
  def index
    redirect_to @listing
  end

  # GET /account_users/1
  def show
    redirect_to @listing
  end

  # GET /account_users/1/edit
  def edit
  end

  # PATCH/PUT /account_users/1
  def update
    if @membership.update(membership_params)
      redirect_to @listing, notice: "Listing member was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /account_users/1
  def destroy
    @membership.destroy
    redirect_to @listing, notice: "Listing member was successfully removed."
  end

  private

  def set_listing
    @listing = current_user.listings.find(params[:listing_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set__membership
    @membership = @listing.memberships.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def membership_params
    params.require(:membership).permit(*AccountUser::ROLES)
  end

  # def require_admin
  #   membership = @listing.memberships.find_by(user: current_user)
  #   if account_user.nil? || !account_user.admin?
  #     redirect_to account_path(@account), notice: "You must be a account admin to do that."
  #   end
  # end
end
