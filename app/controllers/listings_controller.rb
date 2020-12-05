class ListingsController < ApplicationController
  layout :resolve_layout
  before_action :authenticate_user!, except: [:show]
  before_action :set_listing, except: [:index, :public, :new, :create, :join, :members]
  before_action :require_account, except: [:show]
  before_action :require_non_personal_account, :require_subscription, except: [:index, :show, :join]
  helper_method :has_secure_access
  before_action :authorize_show, only: :show

  # GET /listings
  def index
    @pagy, @listings = pagy(current_account.listings.sort_by_params(params[:sort], sort_direction))
    @pagy, @public_listings = pagy(Listing.state("active").private_listing(false).sort_by_params(params[:sort], sort_direction))
    @pagy, @member_listings = pagy(Listing.joins(:memberships).where(memberships: {user_id: current_user.id}).sort_by_params(params[:sort], sort_direction))
  
    @all_listings = (@listings + @member_listings).uniq
  end

  def public
    @pagy, @listings = pagy(Listing.state("active").private_listing(false).sort_by_params(params[:sort], sort_direction))
  end

  def view
  end
 
  # GET /listings/1
  def show
    ahoy.track "Viewed listing", id: @listing.id
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
    @listing = current_account.listings.new(listing_params.merge(owner: current_user))

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

    if user_signed_in?
      member = @listing.memberships.find_by(user_id: current_user.id)

      if member 
        member.secure_access? 
      else
        current_account == @listing.account
      end
    end
  end

  def join
    @listing = Listing.find(params[:listing_id])

    @membership = @listing.memberships.new(user: current_user)

    @contact = @listing.account.contacts.where(account: @listing.account, email: current_user.email).first_or_create do |contact|
      contact.first_name = current_user.first_name
      contact.last_name = current_user.last_name
      contact.owner = current_user
    end

    if @contact
      @membership.contact_ids = @contact.id
    end
    
    if @membership.save
      ahoy.track "Joined listing", id: @listing.id
      redirect_to listing_path(@listing), notice: 'You have successfully joined this listing'
    else
      render :show, notice: 'Something went wrong, please try to join again later.'
    end
    
  end

  def members
    @listing = Listing.find(params[:listing_id])
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

    def authorize_show 
      if @listing.private_listing
        if user_signed_in?
          unless current_account == @listing.account || @listing.memberships.exists?(user_id: current_user.id)
            redirect_to root_path, notice: "You are not allowed to view this listing" 
          end
        else 
          redirect_to root_path, notice: "You are not allowed to view this listing" 
        end
      end
    end

    def resolve_layout
      case action_name
      when "public", "view"
        "public"
      else
        "application"
      end
    end

    # Only allow a trusted parameter "white list" through.
     def listing_params
      params.require(:listing).permit(:owner_id, :account_id, :nda_id, :investment_type, :description, :title, :draft, :private_listing, :price, :noi, 
        properties_attributes: [:primary_type, :secondary_type, :asset_class, :rent_type, :units, :floors, :buildings, :land_area, :zoning, :id, :user_id, :sf, :name, :address, :address1, :address2, :address_city, :address_state, :address_zip, :_destroy], 
        listing_images_attributes: {}, listing_documents_attributes: {}, listing_secure_documents_attributes: {})
    end
end
