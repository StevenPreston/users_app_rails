class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {}, cookies = {})
    @headers = headers
    @cookies = cookies
  end

  def call
    user
  end

  private

  attr_reader :headers, :cookies

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    elsif (cookies[:_app4_token])
      return cookies[:_app4_token]
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end
