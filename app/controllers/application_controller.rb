class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :previous_site

  before_action :require_login
  # rescue_from AccessDenied, with: :record_not_found
  #
  #   class AccessDenied < StandardError
  #    end

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  private

    def require_login
      unless current_user
        redirect_to sign_in_path, notice: "You must be logged in to access that action"
      end
    end

    def project_members
      if Project.where(id: params[:id]).first || Project.where(id: params[:project_id]).first
        if current_user.admin
          @logged_in_user_projects = Project.pluck(:id)
        else
          @logged_in_user_projects = current_user.projects.pluck(:id)
        end
        if @logged_in_user_projects.include? @project.id
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


    # def record_not_found
    #   render plain: "404 Not Found", status: 404
    # end

    # def previous_site
    #   session[:really] = request.env['HTTP_REFERER']
    # end

end
