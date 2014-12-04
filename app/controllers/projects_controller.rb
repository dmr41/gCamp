class ProjectsController < ApplicationController

  before_action :set_project, only: [:edit, :update, :show, :destroy, :project_owner]
  before_action :project_members, only: [:show, :edit, :update, :destroy]
  before_action :project_role, only: [:edit, :destroy, :update]

  def set_project
    if Project.where(id: params[:id]).first
      @project = Project.find(params[:id])
    else
    end
  end

  def index
    if current_user.admin
      @projects = Project.all
    elsif current_user
      @projects = current_user.projects
    end
  end

  def new
    @project = Project.new
    @membership = @project.memberships.new
  end

  def edit
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
    if @role != "Owner"
      render "public/404", status: 404, layout: false
    else
      if @project.update(project_params)
        redirect_to @project, notice: "Project Updated!"
      else
        render :new
      end
    end
  end

  def show
    if current_user.admin
      @role = "Owner"
    else
      @role = @project.memberships.where(user_id: current_user.id).first.role
    end
  end

  def destroy
    if @role == "Owner"
      @project.destroy
      redirect_to projects_path, notice: "Project has been destroyed!"
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end






end
