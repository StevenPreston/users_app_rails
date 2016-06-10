class PlacesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    redirect_to new_session_url unless current_user?(@user)
    @places = @user.places
  end

  def create
    @user = User.find(params[:user_id])
    @place = @user.places.build(place_params)
    @place.save

    redirect_to user_places_url
  end

  private

  def place_params
    params.require(:place).permit(:name, :formatted_address, :lat, :lng)
  end
end