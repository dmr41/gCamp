class MembershipsController < ApplicationController



  def index
    project_owner
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def show
    project_owner
    @membership = @project.memberships.find(params[:id])
  end


  def new
    project_owner
    @membership = @project.memberships.new
  end

  def edit
    project_owner
    @membership = @project.memberships.find(params[:id])
  end


  def create
    project_owner
    @membership = @project.memberships.new(membership_params)
      if @membership.save
        redirect_to project_memberships_path(@project, @membership),
        notice: "#{@membership.user.full_name} was successfully created."
      else
        @memberships = @project.memberships.all
        render :index
      end
  end

  def update
    project_owner
    @membership = @project.memberships.find(params[:id])
      if @membership.update(membership_params)
        redirect_to project_memberships_path(@project, @membership), notice: "#{@membership.user.full_name} was successfully updated."
      else
        render :index
      end
  end

  def destroy
    project_owner
    @membership = @project.memberships.find(params[:id])
    temp_name = @membership.user.full_name
    @membership.destroy
    redirect_to project_memberships_path(@project, @membership), notice: "#{temp_name} was removed successfully."
  end

  private
    def membership_params
      params.require(:membership).permit(:role, :user_id, :project_id)
    end

    def project_owner
      @project = Project.find(params[:project_id])
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



end
