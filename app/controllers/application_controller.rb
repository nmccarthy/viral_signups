class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :authenticate_user, :unless => :currently_at_login

  private

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if current_user.nil?
      redirect_to '/login'
    end
  end

  def currently_at_login
    params[:controller] == 'sessions'
  end
end
