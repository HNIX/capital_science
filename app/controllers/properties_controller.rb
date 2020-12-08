class PropertiesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_property, except: [:index, :new, :create]
    before_action :require_account
    before_action :require_non_personal_account, except: [:index, :show]
  
    # GET /listings
    def index
      @pagy, @properties = pagy(current_account.properties.sort_by_params(params[:sort], sort_direction))
    end
  
    def view
    end
   
    # GET /listings/1
    def show
    end
  
    # GET /listings/new
    def new
      @property = Property.new
    end
  
    # GET /listings/1/edit
    def edit
      unless current_account == @property.account
        redirect_to properties_url, notice: 'You cannot edit a property that doesn\'t belong to you'
      end
    end
  
    # POST /listings
    def create
      # @listing = current_user.listings.new(listing_params)
      @property = current_account.properties.new(property_params)
  
      if @property.save
        redirect_to @property
      else
        render :new
      end
    end
  
    # PATCH/PUT /listings/1
    def update
      # @listing.assign_attributes(listing_params)
  
      if @property.update(property_params)
        redirect_to @property, notice: 'Property was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listings/1
    def destroy
      @property.destroy
      redirect_to properties_url, notice: 'Property was successfully destroyed.'
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_property
        @property = Property.find(params[:id])
      end
  
      def require_account
        unless current_account
          redirect_to new_user_registration_path, notice: "You must create an account." 
        end
      end
  
      def require_non_personal_account
        unless !current_account.personal
          redirect_to accounts_path, notice: "You must create a brokerage account to do that."
        end
      end
  
      def authorize_account 
         @property = Property.find(params[:id])
         unless current_account == @property.account
           redirect_to root_path, notice: "You are not allowed to edit properties that don't belong to you"
         end
      end
  
      # Only allow a trusted parameter "white list" through.
       def property_params
        params.require(:property).permit(:name, :address1, :address2, :address_city, :address_state, :address_zip, :primary_type, 
        :secondary_type, :asset_class, :rent_type, :units, :sf, :floors, :buildings, :land_area, :zoning, :latitude, :longitude, 
        :address, :address_object, :year_built, :rsf, :occupancy, :parking_spaces, :frontage, :apn, :account_id, :listing_id, :highlights, 
        :cover_image, property_images_attributes: {}, contact_ids: [])
      end
  end
  
