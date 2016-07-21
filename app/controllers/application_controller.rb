class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_user
    respond_to do |format|
      format.html {
        redirect_to new_user_url unless current_user
      }
      format.json {
        render json: { error: 'Not Authorized' }, status: 401 unless current_user
      }
    end
  end

  def already_logged_in
    respond_to do |format|
      format.html {
        redirect_to current_user if current_user
      }
      format.json {
        render json: { error: 'Not Authorized' }, status: 401 unless current_user
      }
    end
  end

  def authorize_user
    respond_to do |format|
      format.html {
        redirect_to current_user unless user.id == current_user.id
      }
      format.json {
        render json: { error: 'Not Authorized' }, status: 401 unless user.id == current_user.id
      }
    end
  end

  def current_user
    @current_user = @current_user ||= AuthorizeApiRequest.call(request.headers, cookies).result
  end
  helper_method :current_user

  #def authenticate
  #  command = AuthenticateUser.call(params[:email], params[:password])
  #  if command.success?
  #    render json: { auth_token: command.result }
  #  else
  #    render json: { error: command.errors }, status: :unauthorized
  #  end
  #end
end
