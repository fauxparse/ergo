class EventController < WebsocketRails::BaseController
  def initialize_session
  end

  def connected
    Rails.logger.info "#{current_user.name} connected"
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
