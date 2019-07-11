class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue StandardError => e
      warn(e.message)
      nil
    end
  end

  def authenticate_user!
    redirect_to root_url, :alert => 'You need to sign in for access to this page.' if !current_user
  end
end
