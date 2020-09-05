class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  # before_action :require_admin, except: [:index, :show]
  before_action :set_listing

  # GET /accounts
  def index
    @pagy, @memberships = pagy(@listing.memberships)
  end

  # GET /account_users/1
  def show
    
  end

  # GET /listings/new
  def new   
    @listing = Listing.find(params[:listing_id])
    @membership = Membership.new(listing_id: @listing.id)
  end

  # GET /listings/1/edit
  def edit
    unless current_account == @membership.listing.account
      redirect_to root_url, notice: 'You cannot edit memberships'
    end
  end

  # POST /listings
  def create
    @membership = Membership.new(membership_params)
    
    @membership.user = current_user

    if @membership.save
      redirect_to membership_path(@membership)
    else
      render :new
    end
  end

  # PATCH/PUT /account_users/1
  def update
    if @membership.update(membership_params)
      redirect_to @membership, notice: "Listing member was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /account_users/1
  def destroy
    @membership.destroy
    redirect_to memberships_path, notice: "Listing member was successfully removed."
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def membership_params
    params.require(:membership).permit(*Membership::ROLES, :secure_access, contact_ids: [])
  end

  # def require_admin
  #   membership = @listing.memberships.find_by(user: current_user)
  #   if account_user.nil? || !account_user.admin?
  #     redirect_to account_path(@account), notice: "You must be a account admin to do that."
  #   end
  # end
end
