class PlacesController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    byebug;

    if current_user?(@user)
      @places = @user.places
      respond_to do |format|
        format.html do
          render component: 'Root', props: { token: cookies[:_users_app_session] }, tag: 'div', class: 'todo'
        end
        format.json do
          render json: @places
        end
      end
    else
      respond_to do |format|
        format.html do
          redirect_to new_session_url
        end
        format.json do
          render json: {}, status: 401
        end
      end
    end
  end

  def create
    @user = User.find(params[:user_id])
    @place = @user.places.build(place_params)

    respond_to do |format|
      @result = @place.save
      if @result
        format.js {}
        format.html { redirect_to user_places_url }
      else 
        format.js {}
        format.html do
          flash.now[:error] = @place.errors.full_messages.to_sentence
          redirect_to user_places_url
        end
      end
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :formatted_address, :lat, :lng)
  end
end