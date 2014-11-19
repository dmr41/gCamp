class MembershipsController < ApplicationController

  before_action do
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
        redirect_to project_memberships_path([@project, @membership], notice: 'Membership was successfully created.')
      else
        @user_error = "No user selected"
        redirect_to project_memberships_path(@project, @user_error)
      end
  end

  def update
    @membership = @project.memberships.find(params[:id])
      if @membership.update(membership_params)
        redirect_to project_memberships_path(@project, @membership), notice: 'Membership was successfully updated.'
      else
        render :edit
      end
  end


  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project, incomplete: "Incomplete" ), notice: 'Membership was successfully destroyed.'
  end

  private
    def membership_params
      params.require(:membership).permit(:role, :user_id, :project_id)
    end

end
