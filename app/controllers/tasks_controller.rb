class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json

  def index
    if params[:all_tasks]
      @tasks = Task.order(params[:sort])
      @booly = false
    else
      @tasks = Task.where(complete: false).order(params[:sort])
      @booly = true
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy

    # if @tasks = Task.order(params[:sort])
    if tasks_path(params[:incomplete] )
      redirect_to tasks_path(incomplete: "Incomplete" ), notice: 'Task was successfully destroyed.'
    else
      redirect_to tasks_path(all_task: "All tasks" ), notice: 'Task was successfully destroyed.'
    end
    # elsif @tasks = Task.where(complete: false).order(params[:sort])
    #   redirect_to tasks_path(incomplete: "Incomplete"), notice: 'Task was successfully destroyed.'
    # else
    #   redirect_to tasks_path(all_task: "All tasks" ), notice: 'Task was successfully destroyed.'
    # end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :complete, :date)
    end
end
