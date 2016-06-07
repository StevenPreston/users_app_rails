module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def log_out
    session[:user_id] = nil
    @current_user = nil
  end

  def logged_in?
    current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user && current_user.id == user.id
  end
end
