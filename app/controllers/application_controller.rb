class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private
  def current_user
    @current_user ||= if session[:user_id]
                        User.find(session[:user_id])
                      end
  end
end
