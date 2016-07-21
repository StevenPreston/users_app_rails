class PlacesController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_user

  def index
    @places = @user.places
    respond_to do |format|
      format.html do

        token = nil
        if headers['Authorization'].present?
          token = headers['Authorization'].split(' ').last
        elsif (cookies[:_app4_token])
          token = cookies[:_app4_token]
        end

        render component: 'Root', props: { token: token }, tag: 'div', class: 'todo'
      end
      format.json do
        render json: @places
      end
    end
  end

  def create
    @place = @user.places.build(place_params)

    respond_to do |format|
      @result = @place.save
      if @result
        format.html { redirect_to user_places_url }
      else 
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

  def user
    @user ||= User.find(params[:user_id])
  end
  helper_method :user
end