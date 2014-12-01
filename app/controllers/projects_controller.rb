class ProjectsController < ApplicationController

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
    @project = Project.find(params[:id])
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
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: "Project Updated!"
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project has been destroyed!"
  end

  def project_params
    params.require(:project).permit(:name)
  end


end
