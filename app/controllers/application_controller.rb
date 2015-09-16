class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login, unless: :logged_in?

  helper_method :logged_in?, :current_user

  private

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  def require_login
    session[:return_to] = request.fullpath unless controller_name == "sessions"
    redirect_to :login
  end

  def logged_in?
    current_user.present?
  end
end
