class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_account
  before_action :set_list, except: [:index, :new, :create]

  # GET /listings
  def index
    @pagy, @lists = pagy(current_account.lists.sort_by_params(params[:sort], sort_direction))
  end
 
  # GET /listings/1
  def show
   
  end

  # GET /listings/new
  def new
    @list = List.new
  end

  # GET /listings/1/edit
  def edit
    unless current_account == @contact.account
      redirect_to lists_url, notice: 'You cannot edit a list that doesn\'t belong to you'
    end
  end

  # POST /listings
  def create
    # @listing = current_user.listings.new(listing_params)
    @list = List.new(list_params.merge(owner: current_user))
    @list.account_id = current_account.id

    if @list.save
      render json: @list
    else
      render json: {errors: @list.errors.full_messages}
    end
  end

  # PATCH/PUT /listings/1
  def update
    # @listing.assign_attributes(listing_params)

    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /listings/1
  def destroy
    @list.destroy
    redirect_to lists_url, notice: 'List was successfully destroyed.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    def require_account
      unless current_account
        redirect_to new_user_registration_path, notice: "You must create an account." 
      end
    end

    # Only allow a trusted parameter "white list" through.
     def list_params
      params.require(:list).permit(:name, :account_id, :owner_id)
    end
end
