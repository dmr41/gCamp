class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :shared_project_members, only: [:index, :show]

  def set_user
    if User.where(id: params[:id]).first
      @user = User.find(params[:id])
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    if current_user.admin
      @user = User.new(user_params)
      @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      @user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation))
      @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    end
  end

  def destroy
    if current_user.admin
      @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
    elsif current_user.id == @user.id
      @user.destroy
      redirect_to sign_in_path, notice: 'User was successfully destroyed.'
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def edit
    unless current_user.id == @user.id || current_user.admin
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def update
    if current_user.admin
      @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    elsif current_user.id == @user.id
      @user.update(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation))
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end


  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end


end
