require 'rails_helper'

describe  TasksController do

  describe '#index' do
    it "non logged in user can't access a tasks index page even with correct project id" do
      ownership1 = create_ownership
      task1 = create_task
      task1[:project_id] = ownership1.project.id
      # binding.pry
      get :index, {:project_id => task1.project.id}
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged-in user not associated with any projects can not render tasks index page" do
      membership1 = create_membership
      task1 = create_task
      user1 = create_user
      task1[:project_id] = membership1.project.id
      session[:user_id] = user1.id
      get :index, {:project_id => task1.project.id}
      expect(response.status).to eq(404)
    end

    it "logged in owner can render tasks index page" do
      ownership1 = create_ownership
      task1 = create_task
      task1[:project_id] = ownership1.project.id
      session[:user_id] = ownership1.user.id
      get :index, {:project_id => task1.project.id}
      expect(response).to render_template(:index)
    end

    it "logged in owner of one project can't render tasks on another index page" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      task1 = create_task
      task1[:project_id] = ownership1.project.id
      session[:user_id] = ownership2.user.id
      get :index, {:project_id => task1.project.id}
      expect(response.status).to eq(404)
    end

    it "logged in member can render tasks index page" do
      membership1 = create_membership
      task1 = create_task
      task1[:project_id] = membership1.project.id
      session[:user_id] = membership1.user.id
      get :index, {:project_id => task1.project.id}
      expect(response).to render_template(:index)
    end

    it "admin can render tasks index page" do
      membership1 = create_membership
      task1 = create_task
      user1 = create_super_user
      task1[:project_id] = membership1.project.id
      session[:user_id] = user1.id
      get :index, {:project_id => task1.project.id}
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    it "non logged in user can't access a task show page even with correct project id" do
      task1 = create_task
      get :show, {:project_id => task1.project.id, :id => task1.id}
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged-in user not associated with any projects can not render task show page" do
      membership1 = create_membership
      task1 = create_task
      user1 = create_user
      task1[:project_id] = membership1.project.id
      session[:user_id] = user1.id
      get :show, {:project_id => task1.project.id, :id => task1.id}
      expect(response.status).to eq(404)
    end

    it "logged in non project owners can not render task show page" do
      task1 = create_task
      user1 = create_user
      session[:user_id] = user1.id
      get :show, {:project_id => task1.project.id, :id => task1.id}
      expect(response.status).to eq(404)
    end

    it "logged in owner of one project can't render task show page on another index page" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      task1 = create_task
      task1[:project_id] = ownership1.project.id
      session[:user_id] = ownership2.user.id
      get :show, {:project_id => task1.project.id, :id => task1.id}
      expect(response.status).to eq(404)
    end

    it "logged in member can render task show page" do
      membership1 = create_membership
      task1 = create_task
      task1[:project_id] = membership1.project.id
      session[:user_id] = membership1.user.id
      get :show, {:project_id => task1.project.id, :id => task1.id}
      expect(response).to render_template(:show)
    end

    it "admin can render task show page" do
      task1 = create_task
      user1 = create_super_user
      session[:user_id] = user1.id
      get :show, {:project_id => task1.project_id, :id => task1.id}
      expect(response).to render_template(:show)
    end
  end




end
