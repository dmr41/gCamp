class ProjectsController < ApplicationController

  before_action :set_project, only: [:edit, :update, :show, :destroy, :project_owner]
  before_action :project_members, only: [:show, :edit, :update, :destroy]
  before_action :project_role, only: [:edit, :destroy, :update]\

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
     tracker_api = PivotalApi.new
     @tracker = tracker_api.pivotal_projects(current_user.pivotal_tracker_token)
  end

  def new
    @project = Project.new
    @membership = @project.memberships.new
  end

  def edit
    if @role != "Owner"
      raise AccessDenied
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
      raise AccessDenied
    else
      if @project.update(project_params)
        redirect_to @project, notice: "Project Updated!"
      else
        render :new
      end
    end
  end

  def show_stories
      tracker_api = PivotalApi.new
      @test = params[:id]
      @tracker = tracker_api.pivotal_projects(current_user.pivotal_tracker_token)
      @tracker2 = tracker_api.pivotal_stories(current_user.pivotal_tracker_token, params[:id] )
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
      raise AccessDenied
      #render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  # def pivotal_projects
  #   conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  #
  #   response = conn.get do |req|
  #     req.url "/services/v5/projects"
  #     req.headers['Content-Type'] = 'application/json'
  #     req.headers['X-TrackerToken'] = current_user.pivotal_tracker_token
  #   end
  #
  #   if response.success?
  #     @response_json = JSON.parse(response.body, symbolize_names: true)
  #   end
  # end
  #
  # def pivotal_story_parser
  #   conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  #
  #   response = conn.get do |req|
  #     req.url "/services/v5/projects/#{@test}/stories/"
  #     req.headers['Content-Type'] = 'application/json'
  #     req.headers['X-TrackerToken'] = current_user.pivotal_tracker_token
  #   end
  #
  #   if response.success?
  #     @story_response = JSON.parse(response.body, symbolize_names: true)
  #   end
  # end

  private

    def project_params
      params.require(:project).permit(:name)
    end






end
