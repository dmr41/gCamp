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

  def project_owner
    @logged_in_user_projects = current_user.projects
    project_array =[]
    @logged_in_user_projects.each do |liup|
      project_array << liup.id
    end
    if project_array.include? @project.id
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def find_proj
    @project = Project.find(params[:id])
  end

  def find_members
    @project = Project.find(params[:project_id])
  end

  def find_tasks
    @project = Project.find(params[:project_id])
  end


end
