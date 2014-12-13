class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :previous_site

  before_action :require_login

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  def require_login
    deny_access unless current_user.present?
  end

  def record_not_found
    render file: 'public/404', status: :not_found, layout: false
  end

  def deny_access
    store_location
    redirect_to sign_in_path, notice: "Please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end

  def pluck_user_project_ids
    if current_user.admin
      @logged_in_user_projects = Project.pluck(:id)
    else
      @logged_in_user_projects = current_user.projects.pluck(:id)
    end
  end

  def logged_users_have_projects
    if @logged_in_user_projects.include? @project.id
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def project_members
    if Project.where(id: params[:id]).first || Project.where(id: params[:project_id]).first
      pluck_user_project_ids
      logged_users_have_projects
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def project_role
    if current_user.admin
      @role = "Owner"
    else
      @role = @project.memberships.where(user_id: current_user.id).first.role
    end
  end

  def project_owner_count
    total_owners = @project.memberships.where(role: "Owner")
    total_members = @project.memberships.where(role: "Member")
    @owner_count = total_owners.count
    @total_member_count = total_owners.count + total_members.count
  end

  def shared_project_members
    @users = User.all
    @membership_id_array = current_user.projects.pluck(:project_id)
    @common_users = []
    @users.each do |user|
      user_projects = user.projects.pluck(:project_id)
      @membership_id_array.each do |member|
        if user_projects.include?(member)
          @common_users << user.id
        end
      end
    end
  end
end
