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
    end
  end

  def project_members
    if Project.where(id: params[:id]).first || Project.where(id: params[:project_id]).first
      if current_user.admin
        @logged_in_user_projects = Project.all
      else
        @logged_in_user_projects = current_user.projects
      end
      project_array =[]
      @logged_in_user_projects.each do |liup|
        project_array << liup.id
      end
      if project_array.include? @project.id
      else
        render file: 'public/404.html', status: :not_found, layout: false
      end
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def project_role
    if current_user.admin
      @role = "Owner"
    else
      member = @project.memberships.where(user_id: current_user.id)
      @role = member[0].role
    end
  end

  def project_owner_count
    total_owners = @project.memberships.where(role: "Owner")
    @owner_count = total_owners.count
  end


end
