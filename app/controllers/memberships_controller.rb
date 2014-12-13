class MembershipsController < ApplicationController
  before_action :set_project
  before_action :project_members, only: [:index, :show, :new, :edit, :create, :update, :destroy ]
  before_action :project_role, only: [:index, :create, :destroy, :update]
  before_action :project_owner_count, only: [:index, :destroy, :update, :create]

  def set_project
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
        redirect_to project_memberships_path(@project),
        notice: "#{@membership.user.full_name} was successfully created."
      else
        @memberships = @project.memberships.all
        render :index
      end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @role == 'Owner' && @owner_count == 1 && @membership.user.id == current_user.id
       redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} is the only owner remaining."
    elsif @role == 'Owner' || current_user.admin
      if @membership.update(membership_params)
        redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated."
      else
        render :index
      end
    else @role == 'Member'
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  # def destroy
  #   @membership = @project.memberships.find(params[:id])
  #   temp_name = @membership.user.full_name
  #   if current_user
  #     if current_user.admin
  #       @membership.destroy
  #       redirect_to project_memberships_path(@project), notice: "#{temp_name} was removed successfully."
  #     elsif @role == 'Member' &&  @membership.user.id == current_user.id
  #       @membership.destroy
  #       redirect_to projects_path, notice: "#{temp_name} was removed successfully."
  #     elsif @role == 'Owner' && @owner_count > 1
  #       if @membership.user.id != current_user.id
  #         @membership.destroy
  #         redirect_to project_memberships_path(@project), notice: "#{temp_name} was removed successfully."
  #       else
  #         @membership.destroy
  #         redirect_to projects_path
  #       end
  #     elsif @role == 'Owner'
  #       if @membership.user.id == current_user.id && @owner_count != 1
  #          @membership.destroy
  #          redirect_to project_memberships_path(@project), notice: "#{temp_name} was removed successfully."
  #       elsif @membership.user.id != current_user.id && @owner_count == 1
  #          @membership.destroy
  #          redirect_to project_memberships_path(@project), notice: "#{temp_name} was removed successfully."
  #       else
  #          redirect_to project_memberships_path(@project), notice: "#{temp_name} is the only owner of the project and can't be removed."
  #       end
  #     end
  #    else
  #      render file: 'public/404.html', status: :not_found, layout: false
  #    end
  # end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @temp_name = @membership.user.full_name
    if current_user
      if single_owner || multiple_owner
        @membership.destroy
        redirect_to project_memberships_path(@project), notice: "#{@temp_name} was removed successfully."
      elsif self_destroy
        @membership.destroy
        redirect_to projects_path, notice: "#{@temp_name} was removed successfully."
      else
        redirect_to project_memberships_path(@project), notice: "#{@temp_name} is the only owner of the project and can't be removed."
      end
    end
  end

  private
    def membership_params
      params.require(:membership).permit(:role, :user_id, :project_id)
    end

  def multiple_owner
    if current_user.admin
      return true
    elsif @role == 'Owner' && @owner_count > 1 && @membership.user.id != current_user.id
      return true
    else
    end
  end

  def self_destroy
    if @role == 'Owner' && @owner_count > 1 && @membership.user.id == current_user.id
      return true
    elsif @role == 'Member' && @membership.user.id == current_user.id
      return true
    else
    end
  end

  def single_owner
    if  @role == 'Owner' && @membership.user.id != current_user.id && @owner_count != 1
      return true
    elsif  @role == 'Owner' && @membership.user.id != current_user.id && @owner_count == 1
      return true
    else
    end
  end

end
