class SessionsController < ApplicationController
  before_action :already_logged_in, only: :new
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    command = AuthenticateUser.call(params[:session][:email], params[:session][:password])

    if user && command.success?
      cookies[:_app4_token] = command.result
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
