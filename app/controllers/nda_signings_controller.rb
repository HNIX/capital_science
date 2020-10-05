class NdaSigningsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, except: :index
  before_action :set_nda_signing, except: [:index, :new, :create]
  #before_action :require_non_personal_account, :require_subscription, except: [:index, :public_listings, :show]

  # GET /listings
  def index
    # @pagy, @nda_signings = pagy(current_account.nda_signings.sort_by_params(params[:sort], sort_direction))
    # @pagy, @user_nda_signings = pagy(current_user.nda_signings.sort_by_params(params[:sort], sort_direction))

    if params[:listing_id]
      @nda_signings = Listing.find(params[:listing_id]).nda_signings
    else
      @pagy, @nda_signings = pagy(current_account.nda_signings.sort_by_params(params[:sort], sort_direction))
      @pagy, @user_nda_signings = pagy(current_user.nda_signings.sort_by_params(params[:sort], sort_direction))
      
    end
  end

  # GET /listings/1
  def show
    @listing = @nda_signing.listing 

   unless current_account == @nda_signing.account || current_user == @nda_signing.user
     redirect_to listing_path(@listing), notice: "You are not allowed to view this NDA"
   end

   respond_to do |format|
     format.html
     format.pdf do
       render template: 'nda_signings/show.html.erb', pdf: 'Non-Disclosure Agreement-' + Time.now.strftime('%v %H:%M:%S').to_s, javascript_delay: 10000,
       layout: 'pdf.html.erb', disposition: 'attachment'
     end
    end
  end

  # GET /listings/new
  def new
    @nda_signing = NdaSigning.new
    ahoy.track "Started Agreement Signing", id: @listing.id
  end

  # GET /listings/1/edit
  def edit
     redirect_to listing_ndas_url, notice: 'You cannot edit an NDA after it has been signed'
  end

  # POST /listings
  def create
  	@nda_signing = current_user.nda_signings.new(nda_signing_params)
    @nda_signing.account_id = @listing.account.id
    @nda_signing.listing_id = @listing.id
    @nda_signing.ip_address = request.remote_ip

    if @nda_signing.save
      ahoy.track "Signed Agreement", id: @listing.id
      redirect_to listing_nda_signing_path(@listing, @nda_signing), notice: 'Your NDA was successfully signed'
    else
      render :new
    end
  end

  # PATCH/PUT /listings/1
  def update
   redirect_to listing_ndas_url(@listing), notice: 'You cannot edit an NDA after it has been signed'
  end

  # DELETE /listings/1
  def destroy
    @nda_signing.destroy
    redirect_to root_path, notice: 'NDA was successfully destroyed.'
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_nda_signing
      @nda_signing = NdaSigning.find(params[:id])
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    # Only allow a trusted parameter "white list" through.
    def nda_signing_params
      params.require(:nda_signing).permit(:signed_on, :signature, :ip_address, :content, :account_id, :listing_id, :user_id)
    end
end

