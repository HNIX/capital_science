class ActivitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_account
    before_action :set_activity, except: [:index, :new, :create]
  
    # GET /listings
    def index
      @pagy, @activities = pagy(current_account.activities.sort_by_params(params[:sort], sort_direction))
    end
   
    # GET /listings/1
    def show
     
    end
  
    # GET /listings/new
    def new
      @activity = Activity.new
    end
  
    # GET /listings/1/edit
    def edit
      unless current_account == @activity.account
        redirect_to activities_url, notice: 'You cannot edit an activity that doesn\'t belong to you'
      end
    end
  
    def create
      @activity = current_account.activities.new(activity_params.merge(owner: current_user))
  
      if @activity.save
        redirect_to @activity
      else
        render :new
      end
    end
  
    # PATCH/PUT /listings/1
    def update
      # @listing.assign_attributes(listing_params)
  
      if @activity.update(activity_params)
        redirect_to @activity, notice: 'Activity was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listings/1
    def destroy
      @activity.destroy
      redirect_to activities_url, notice: 'Activity was successfully destroyed.'
    end
  
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_activity
        @activity = Activity.find(params[:id])
      end
  
      def require_account
        unless current_account
          redirect_to new_user_registration_path, notice: "You must create an account." 
        end
      end
  
      # Only allow a trusted parameter "white list" through.
       def activity_params
        params.require(:activity).permit(:event, :account_id, :owner_id, :comment, :due_date, :status, contact_ids: [], listing_ids: [], user_ids: [])
      end
  end
  