class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def show
    activities = Activity.where(user: current_user)
    render :json => activities
  end
end