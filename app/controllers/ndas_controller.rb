class NdasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_nda, except: [:index, :new, :create]
  before_action :require_account
  #before_action :require_non_personal_account, :require_subscription, except: [:index, :public_listings, :show]

  # GET /listings
  def index
    @pagy, @ndas = pagy(current_account.ndas.sort_by_params(params[:sort], sort_direction))
  end

  # GET /listings/1
  def show
   unless current_account == @nda.account
     redirect_to root_path, notice: "You are not allowed to view this NDA"
   end
  end

  # GET /listings/new
  def new
    @nda = Nda.new
  end

  # GET /listings/1/edit
  def edit
    unless current_account == @nda.account
      redirect_to account_ndas_url, notice: 'You cannot edit a NDA that doesn\'t belong to you'
    end
  end

  # POST /listings
  def create
    @nda = current_account.ndas.new(nda_params)

    if @nda.save
      redirect_to account_ndas_url, notice: 'Your new NDA was created'
    else
      render :new
    end
  end

  # PATCH/PUT /listings/1
  def update
    # @listing.assign_attributes(listing_params)

    if @nda.update(nda_params)
      redirect_to account_nda_path(current_account, @nda), notice: 'NDA was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /listings/1
  def destroy
    @nda.destroy
    redirect_to account_ndas_url, notice: 'NDA was successfully destroyed.'
  end

  private
    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_nda
      @nda = Nda.find(params[:id])
    end

    def require_account
      unless current_account
        redirect_to new_user_registration_path, notice: "You must create an account." 
      end
    end

    def require_subscription
      unless current_account.subscribed?
        redirect_to pricing_path, notice: "You must select a plan to create an NDA."
      end
    end

    def require_non_personal_account
      unless !current_account.personal
        redirect_to accounts_path, notice: "You must create a brokerage account to do that."
      end
    end

    def authorize_account 
       @nda = Nda.find(params[:id])
       unless current_account == @nda.account
         redirect_to root_path, notice: "You are not allowed to edit NDAs that don't belong to you"
       end
    end


    # Only allow a trusted parameter "white list" through.
    def nda_params
      params.require(:nda).permit(:name, :content, :account_id)
    end
end
