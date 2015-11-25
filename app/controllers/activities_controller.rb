class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    activities = Activity.where(user: current_user)
    render :json => activities
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    @activity.save
    
    render :json => @activity
  end

  private

    def activity_params
      params.require(:activity).permit(:name, :item, :item_type)
    end
end