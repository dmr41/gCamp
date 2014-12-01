class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login


  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def require_login
    unless current_user
      redirect_to sign_in_path, notice: "You must be logged in to access that action"
    #  render file: 'public/404.html', status: :not_found, layout: false
    end
  end


end
