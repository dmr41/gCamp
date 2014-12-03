class MembershipsController < ApplicationController
  before_action :set_proj
  before_action :project_members, only: [:index, :show, :new, :edit, :create, :update, :destroy ]
  before_action :project_role, only: [:index, :create, :destroy]
  before_action :project_owner_count, only: [:index, :destroy]

  def set_proj
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def show
    @membership = @project.memberships.find(params[:id])
  end


  def new
    @membership = @project.memberships.new
  end

  def edit
    @membership = @project.memberships.find(params[:id])
  end


  def create
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
    @membership = @project.memberships.find(params[:id])
      if @membership.update(membership_params)
        redirect_to project_memberships_path(@project, @membership), notice: "#{@membership.user.full_name} was successfully updated."
      else
        render :index
      end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    temp_name = @membership.user.full_name
    if @role == 'Member' &&  @membership.user.id == current_user.id
      @membership.destroy
      redirect_to projects_path, notice: "#{temp_name} was removed successfully."
    elsif @role == 'Owner' && @owner_count > 1
      @membership.destroy
      redirect_to project_memberships_path(@project, @membership), notice: "#{temp_name} was removed successfully."
    elsif @role == 'Owner'
      if @membership.user.id != current_user.id
         @membership.destroy
         redirect_to project_memberships_path(@project, @membership), notice: "#{temp_name} was removed successfully."
       else
         redirect_to project_memberships_path(@project, @membership), notice: "#{temp_name} is the only owner of the project and can't be removed."
       end
      end
    end

  private
    def membership_params
      params.require(:membership).permit(:role, :user_id, :project_id)
    end


end
