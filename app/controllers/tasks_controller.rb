class TasksController < ApplicationController
    # @tasks = Task.where(params[project_id: @project.id])
    # @tasks.last.project_id

  before_action :task_user
  def task_user
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


  def index
    if params[:all_tasks]
      @tasks = @project.tasks.order(params[:sort])
      @booly = false
    else
      @tasks = @project.tasks.where(complete: false).order(params[:sort])
      @booly = true
    end
  end


  # GET /tasks/1.json
  def show
    @task = @project.tasks.find(params[:id])
    @comment = @task.comments.new
    @comments = @task.comments.all
  end

  def create_comment
    @task = @project.tasks.find(params[:id])
    if current_user
      @comment = @task.comments.new(params.require(:comment).merge({:user_id => current_user.id}).permit(:description, :user_id, :task_id))
      @comment.save
      redirect_to project_task_path()
    else
      @comment = @task.comments.new
      @comments = @task.comments.all
      render :show
    end
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)
      if @task.save
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = @project.tasks.find(params[:id])
      if @task.update(task_params)
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    # if @tasks = Task.order(params[:sort])
    if project_tasks_path(@project, params[:incomplete])
      redirect_to project_tasks_path(@project, incomplete: "Incomplete" ), notice: 'Task was successfully destroyed.'
    else
      redirect_to project_tasks_path(@project, all_task: "All tasks" ), notice: 'Task was successfully destroyed.'
    end
    # elsif @tasks = Task.where(complete: false).order(params[:sort])
    #   redirect_to tasks_path(incomplete: "Incomplete"), notice: 'Task was successfully destroyed.'
    # else
    #   redirect_to tasks_path(all_task: "All tasks" ), notice: 'Task was successfully destroyed.'
    # end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :complete, :date)
    end
end
