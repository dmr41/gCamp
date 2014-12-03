class ProjectsController < ApplicationController

  before_action :project_owner, only: [:show]

  def index
    if current_user
      @projects = current_user.projects
    end
  end

  def new
    @project = Project.new
    @membership = @project.memberships.new
  end

  def edit
    project_owner
    member = @project.memberships.where(user_id: current_user.id)
    @role = member[0].role
    if @role != "Owner"
      render "public/404", status: 404, layout: false
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @membership = @project.memberships.create(role: "Owner", user_id: current_user.id, project_id: @project.id)
      redirect_to project_tasks_path(@project), notice: "Project Created!"
    else
      render :new
    end
  end

  def update
    project_owner
    if @project.update(project_params)
      redirect_to @project, notice: "Project Updated!"
    else
      render :new
    end
  end

  def show
    # project_owner
    # if !@project.memberships.where(user_id: current_user.id).first.nil?
    @role = @project.memberships.where(user_id: current_user.id).first.role
    # # else
    # # end
  end

  def destroy
    project_owner
    @project.destroy
    redirect_to projects_path, notice: "Project has been destroyed!"
  end


  private

    def project_params
      params.require(:project).permit(:name)
    end

    def project_owner
       if Project.where(id: params[:id]).first
         @project = Project.find(params[:id])
         @logged_in_user_projects = current_user.projects
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




end
