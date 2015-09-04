class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?

  def logged_in?
    !session[:fb].nil?
  end

  def fb
    @fb ||= FbCommunicator.new(session.fetch(:fb, {}).fetch('access_token', nil))
  end
end
