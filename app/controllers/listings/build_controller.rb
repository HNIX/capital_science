class Listings::BuildController < ApplicationController
  include Wicked::Wizard

  steps :add_properties, :add_images, :add_documents, :add_secure_documents

  def show
    @listing = Listing.find(params[:listing_id])
    render_wizard
  end


  def update
    @listing = Listing.find(params[:listingid])
    @listing.update_attributes(params[:listing])
    render_wizard @listing
  end


  def create
    @listing = Listing.create
    redirect_to wizard_path(steps.first, listing_id: @listing.id)
  end
end