class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_account
  before_action :set_contact, except: [:index, :new, :create]

  # GET /listings
  def index
    @pagy, @contacts = pagy(current_account.contacts.sort_by_params(params[:sort], sort_direction))
  end
 
  # GET /listings/1
  def show
   
  end

  # GET /listings/new
  def new
    @contact = Contact.new
  end

  # GET /listings/1/edit
  def edit
    unless current_account == @contact.account
      redirect_to contacts_url, notice: 'You cannot edit a contact that doesn\'t belong to you'
    end
  end

  # POST /listings
  def create
    # @listing = current_user.listings.new(listing_params)
    @contact = current_account.contacts.new(contact_params.merge(owner: current_user))

    if @contact.save
      redirect_to contacts_path
    else
      render :new
    end
  end

  # PATCH/PUT /listings/1
  def update
    # @listing.assign_attributes(listing_params)

    if @contact.update(contact_params)
      redirect_to @contact, notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /listings/1
  def destroy
    @contact.destroy
    redirect_to contacts_url, notice: 'Contact was successfully destroyed.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def require_account
      unless current_account
        redirect_to new_user_registration_path, notice: "You must create an account." 
      end
    end

    # Only allow a trusted parameter "white list" through.
     def contact_params
      params.require(:contact).permit(*Membership::ROLES, :first_name, :last_name, :email, :phone, :account_id, :user_id, :owner_id, list_ids: [])
    end
end
