class ApplicationController < ActionController::Base
  before_action :current_user

  private

  def current_user
    return unless cookies[:session_key]

    session = Session.find_by(session_key: cookies[:session_key])
    @current_user = session.user
  rescue
    return
  end
end
