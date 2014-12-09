class TasksController < ApplicationController

    before_action :set_project
    before_action :project_members

  def set_project
    @project = Project.find(params[:project_id])
  end

  def index
    @tasks = @project.tasks.all
    # if params[:all_tasks]
    #   @tasks = @project.tasks.order(params[:sort])
    #   @booly = false
    # else
    #   @tasks = @project.tasks.where(complete: false).order(params[:sort])
    #   @booly = true
    # end
  end


  def show
    if @project.tasks.where(id: params[:id]).first
      @task = @project.tasks.find(params[:id])
      @comment = @task.comments.new
      @comments = @task.comments.all
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
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

  def new
    @task = @project.tasks.new
  end


  def edit
    if @project.tasks.where(id: params[:id]).first
      @task = @project.tasks.find(params[:id])
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end


  def create
    @task = @project.tasks.new(task_params)
      if @task.save
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
      else
        render :new
      end
  end


  def update
      @task = @project.tasks.find(params[:id])
      if @task.update(task_params)
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    # if project_tasks_path(@project, params[:incomplete])
    #   redirect_to project_tasks_path(@project, incomplete: "Incomplete" ), notice: 'Task was successfully destroyed.'
    # else
    #   redirect_to project_tasks_path(@project, all_task: "All tasks" ), notice: 'Task was successfully destroyed.'
    # end
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private

    def task_params
      params.require(:task).permit(:description, :complete, :date)
    end

end
