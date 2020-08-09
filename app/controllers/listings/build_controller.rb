class Listings::BuildController < ApplicationController
  include Wicked::Wizard

  steps :add_properties, :property_details, :add_images, :add_documents, :add_secure_documents

  def show
    @listing = Listing.find(params[:listing_id])
    case step
    when :property_details
      if @listing.properties.exists?
        @properties = @listing.properties
      else
        skip_step
      end
    end
    render_wizard
  end


  def update
    @listing = Listing.find(params[:listing_id])
    @listing.update_attributes(listing_params)
    render_wizard @listing
  end


  def create
    @listing = Listing.create
    redirect_to wizard_path(steps.first, listing_id: @listing.id)
  end

  private
  # Only allow a trusted parameter "white list" through.
    def listing_params
      params.require(:listing).permit(:owner_id, :account_id, :nda_id, :investment_type, :description, :title, :draft, :private_listing, :price, :noi, properties_attributes: [:id, :user_id, :name, :address1, :address2, :address_city, :address_state, :address_zip, :_destroy], 
        listing_images_attributes: {}, listing_documents_attributes: {}, listing_secure_documents_attributes: {})
    end
end