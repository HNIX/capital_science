class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:public_listings, :show]
  before_action :set_listing, except: [:index, :public_listings, :new, :create]
  before_action :require_account, except: [:public_listings, :show]
  before_action :require_non_personal_account, :require_subscription, except: [:index, :public_listings, :show]
  helper_method :has_secure_access

  # GET /listings
  def index
    @pagy, @listings = pagy(current_account.listings.sort_by_params(params[:sort], sort_direction))
    @pagy, @public_listings = pagy(Listing.state("active").private_listing(false).sort_by_params(params[:sort], sort_direction))
    @pagy, @memberships = pagy(current_user.memberships.sort_by_params(params[:sort], sort_direction))
  end

  def public_listings
    @pagy, @listings = pagy(Listing.state("active").private_listing(false).sort_by_params(params[:sort], sort_direction))
  end
 
  # GET /listings/1
  def show
   unless current_account == @listing.account || !@listing.private_listing || @listing.memberships.exists?(user_id: current_user.id)
     redirect_to root_path, notice: "You are not allowed to view this listing"
   end
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
    # @listing = current_user.listings.new(listing_params)
    @listing = Listing.new(listing_params.merge(owner: current_user))
    @listing.account_id = current_account.id

    if @listing.save
      redirect_to listing_build_path(@listing, :add_properties)
    else
      render :new
    end
  end

  # PATCH/PUT /listings/1
  def update
    # @listing.assign_attributes(listing_params)

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
    
    @listing.touch(:active_at)
    
    redirect_to @listing
  end

  def stop
    @listing.stop!

    @listing.touch(:inactive_at)

    redirect_to @listing
  end

  def start
    @listing.start!

    @listing.touch(:active_at)

    redirect_to @listing
  end

  def close
    @listing.close!

    @listing.touch(:closed_at)

    redirect_to @listing
  end

  def open
    @listing.open!

    @listing.touch(:inactive_at)

    redirect_to @listing
  end

  def has_secure_access
    member = @listing.memberships.find_by(user_id: current_user.id)
    current_account == @listing.account || member.secure_access? 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def require_account
      unless current_account
        redirect_to new_user_registration_path, notice: "You must create an account." 
      end
    end

    def require_subscription
      unless current_account.subscribed?
        redirect_to pricing_path, notice: "You must select a plan to create listings."
      end
    end

    def require_non_personal_account
      unless !current_account.personal
        redirect_to accounts_path, notice: "You must create a brokerage account to do that."
      end
    end

    def authorize_account 
       @listing = Listing.find(params[:id])
       unless current_account == @listing.account
         redirect_to root_path, notice: "You are not allowed to edit listings that don't belong to you"
       end
    end


    # Only allow a trusted parameter "white list" through.
    def listing_params
      params.require(:listing).permit(:owner_id, :account_id, :nda_id, :description, :title, :draft, :private_listing, 
        :type, :price, :noi, properties_attributes: [:id, :user_id, :name, :address1, :address2, :address_city, :address_state, :address_zip, :_destroy], 
        listing_images_attributes: {}, listing_documents_attributes: {}, listing_secure_documents_attributes: {})
    end
end
