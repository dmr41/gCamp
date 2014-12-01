class AuthenticationController < ApplicationController
  skip_before_filter :require_login
  def create
    user = User.find_by_email(params[:authentication][:email].downcase)
    if user && user.authenticate(params[:authentication][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      @sign_in_error = "Username / password combination is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
