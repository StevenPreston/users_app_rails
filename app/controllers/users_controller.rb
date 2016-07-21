class UsersController < ApplicationController
  #before_action :logged_in_user, only: :new
  before_action :authenticate_user, only: :show
  before_action :authorize_user, only: :show
  before_action :already_logged_in, only: :new
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def user
    @user ||= User.find(params[:id])
  end
  helper_method :user
end
