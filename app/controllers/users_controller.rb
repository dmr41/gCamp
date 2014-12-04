class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def set_user
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.id == @user.id
      @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end


  def edit
    unless current_user.id == @user.id
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def update
    if current_user.id == @user.id
      @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end


  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end


end
