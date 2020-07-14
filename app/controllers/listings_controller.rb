class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :validate_account, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :publish, :stop, :start, :close, :open]

  # GET /listings
  def index
    @pagy, @listings = pagy(Listing.state("active").private_listing(false).sort_by_params(params[:sort], sort_direction))
  end

  def account_listings
    @account = current_account_user.account
    @pagy, @listings = pagy(Listing.account(@account).sort_by_params(params[:sort], sort_direction))
  end
 
  # GET /listings/1
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @listing.properties.new
  end

  # GET /listings/1/edit
  def edit
    unless current_account == @listing.account
      redirect_to listings_url, notice: 'You cannot edit a listing that doesn\'t belong to you'
    end
  end

  # POST /listings
  def create
    @listing = current_user.listings.new(listing_params)
    @listing.account = current_account
    @listing.properties.each{ |property| property.user = current_user }

    if @listing.save
      redirect_to @listing, notice: 'Listing was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /listings/1
  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: 'Listing was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /listings/1
  def destroy
    @listing.destroy
    redirect_to listings_url, notice: 'Listing was successfully destroyed.'
  end

  # AASM Events
  def publish
    @listing.publish!
    redirect_to @listing
  end

  def stop
    @listing.stop!
    redirect_to @listing
  end

  def start
    @listing.start!
    redirect_to @listing
  end

  def close
    @listing.close!
    redirect_to @listing
  end

  def open
    @listing.open!
    redirect_to @listing
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def validate_account
      @account = current_account_user.account

      unless !@account.personal && @account.subscribed?
        if @account.personal
          redirect_to accounts_path, notice: "You must create a brokerage account to do that."
        else
          redirect_to new_subscription_path, notice: "You must select a plan to create listings."
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    def listing_params
      params.require(:listing).permit(:user_id, :account_id, :title, :draft, :private, properties_attributies: [:name, :address1, :address2, :address_city, :address_state, :address_zip])
    end
end
