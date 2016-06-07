class SessionsController < ApplicationController
  before_action :logged_in_user, only: :new
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
       log_in user
       redirect_to user
    else
      flash.now[:error] = 'Unknown user or incorrect username and password'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end
end