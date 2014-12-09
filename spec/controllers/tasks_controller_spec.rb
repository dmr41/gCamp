require 'rails_helper'

describe  TasksController do

  describe '#index' do
    it "non logged in user can't access a tasks index page even with correct project id" do
      ownership1 = create_ownership
      task1 = create_task(project: ownership1.project)
      get :index, {:project_id => task1.project.id}
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged-in user not associated with any projects can not render tasks index page" do
      membership1 = create_membership
      task1 = create_task(project: membership1.project)
      user1 = create_user
      session[:user_id] = user1.id
      get :index, {:project_id => task1.project.id}
      expect(response.status).to eq(404)
    end

    it "logged in owner can render tasks index page" do
      ownership1 = create_ownership
      task1 = create_task(project: ownership1.project)
      session[:user_id] = ownership1.user.id
      get :index, {:project_id => task1.project.id}
      expect(response).to render_template(:index)
    end

    it "logged in owner of one project can't render tasks on another index page" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      task1 = create_task(project: ownership1.project)
      session[:user_id] = ownership2.user.id
      get :index, {:project_id => task1.project.id}
      expect(response.status).to eq(404)
    end

    it "logged in member can render tasks index page" do
      membership1 = create_membership
      task1 = create_task(project: membership1.project)
      session[:user_id] = membership1.user.id
      get :index, {:project_id => task1.project.id}
      expect(response).to render_template(:index)
    end

    it "admin can render tasks index page" do
      membership1 = create_membership
      task1 = create_task(project: membership1.project)
      user1 = create_super_user
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
      task1 = create_task(project: membership1.project)
      user1 = create_user
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
      task1 = create_task(project: ownership1.project)
      session[:user_id] = ownership2.user.id
      get :show, {:project_id => task1.project.id, :id => task1.id}
      expect(response.status).to eq(404)
    end

    it "logged in member can render task show page" do
      membership1 = create_membership
      task1 = create_task(project: membership1.project)
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

  describe '#new' do
    it "non-logged in visitors can't see new tasks page" do
      user1 = create_user
      project1 = create_project
      get :new, {:project_id => project1.id}
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged in members can see new tasks page associated with a project" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      get :new, {:project_id => membership1.project.id}
      expect(response).to render_template(:new)
    end

    it "logged in members can't see new tasks page associated with a project they are not associated with" do
      membership1 = create_membership
      membership2 = create_membership
      session[:user_id] = membership1.user.id
      get :new, {:project_id => membership2.project.id}
      expect(response.status).to eq(404)
    end

    it "logged in owners can see new tasks page associated with a project" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      get :new, {:project_id => ownership1.project.id}
      expect(response).to render_template(:new)
    end

    it "logged in owners can't see new tasks page associated with a project they are not associated with" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      session[:user_id] = ownership1.user.id
      get :new, {:project_id => ownership2.project.id}
      expect(response.status).to eq(404)
    end
    it "admin see new tasks page associated with a project they are not associated with" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      user1 = create_super_user
      session[:user_id] = user1.id
      get :new, {:project_id => ownership1.project.id}
      expect(response).to render_template(:new)
      get :new, {:project_id => ownership2.project.id}
      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    it "non-logged in visitors can't see edit task page" do
      membership1 = create_membership
      task1 = create_task(project: membership1.project)
      get :edit, {:project_id => membership1.project.id, :id => task1.id}
      expect(response).to redirect_to(sign_in_path)
    end

    it "Logged in member can see edit task page" do
      membership1 = create_membership
      task1 = create_task(project: membership1.project)
      session[:user_id] = membership1.user.id
      get :edit, {:project_id => membership1.project.id, :id => task1.id}
      expect(response).to render_template(:edit)
    end

    it "Logged in owner can see edit task page" do
      ownership1 = create_ownership
      task1 = create_task(project: ownership1.project)
      session[:user_id] = ownership1.user.id
      get :edit, {:project_id => ownership1.project.id, :id => task1.id}
      expect(response).to render_template(:edit)
    end

    it "Logged in owner can't see edit task page for a project they don't own" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      task1 = create_task(project: ownership1.project)
      session[:user_id] = ownership2.user.id
      get :edit, {:project_id => ownership1.project.id, :id => task1.id}
      expect(response.status).to eq(404)
    end

    it "admin can see edit task page for projects they are not apart of" do
      ownership1 = create_ownership
      task1 = create_task(project: ownership1.project)
      user1 = create_super_user
      session[:user_id] = user1.id
      get :edit, {:project_id => ownership1.project.id, :id => task1.id}
      expect(response).to render_template(:edit)
    end
  end

  describe '#create' do
    it "non-logged in visitors can't create a task" do
      membership1 = create_membership
      task1 = create_task(project: membership1.project)
      post :create, :project_id => membership1.project.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged in members of a project can create a task" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      post :create, :project_id => membership1.project.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(project_task_path(membership1.project, Task.last))
    end

    it "logged in owners of a project can create a task" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      post :create, :project_id => ownership1.project.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(project_task_path(ownership1.project, Task.last))
    end

    it "admin can create a task anywhere" do
      ownership1 = create_ownership
      user1 = create_super_user
      session[:user_id] = user1.id
      post :create, :project_id => ownership1.project.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(project_task_path(ownership1.project, Task.last))
    end
  end


  describe '#update' do
    it "non-logged in visitors can't update a task" do
      membership1 = create_membership
      task1 = create_task(:project => membership1.project)
      put :update, :project_id => membership1.project.id, :id => task1.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged in members of a project can update a task" do
      membership1 = create_membership
      task1 = create_task(:project => membership1.project)
      session[:user_id] = membership1.user.id
      put :update, :project_id => membership1.project.id, :id => task1.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(project_task_path(membership1.project, task1.id))
    end

    it "logged in owners of a project can update a task" do
      ownership1 = create_ownership
      task1 = create_task(:project => ownership1.project)
      session[:user_id] = ownership1.user.id
      put :update, :project_id => ownership1.project.id, :id => task1.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(project_task_path(ownership1.project, task1.id))
    end


    it "admin can update a task anywhere there is s project" do
      ownership1 = create_ownership
      task1 = create_task(:project => ownership1.project)
      user1 = create_super_user
      session[:user_id] = user1.id
      put :update, :project_id => ownership1.project.id, :id => task1.id, :task => {description: "stuff", complete: false}
      expect(response).to redirect_to(project_task_path(ownership1.project, task1.id))
    end
  end

  describe '#destroy' do
    it "visitors can't destroy a task" do
      membership1 = create_membership
      task1 = create_task(:project => membership1.project)
      user1 = create_user
      session[:user_id] = user1.id
      delete :destroy, :project_id => membership1.project.id, :id => task1.id
      expect(response.status).to eq(404)
    end

    it "logged in members of a project can destroy a task" do
      membership1 = create_membership
      task1 = create_task(:project => membership1.project)
      session[:user_id] = membership1.user.id
      delete :destroy, :project_id => membership1.project.id, :id => task1.id
      expect(response).to redirect_to(project_tasks_path(membership1.project))
    end

    it "logged in members of can't delete another members tasks" do
      membership1 = create_membership
      membership2 = create_membership
      task1 = create_task(:project => membership1.project)
      session[:user_id] = membership2.user.id
      delete :destroy, :project_id => membership1.project.id, :id => task1.id
      expect(response.status).to eq(404)
    end

    it "logged in owners of a project can destroy a task" do
      ownership1 = create_ownership
      task1 = create_task(:project => ownership1.project)
      session[:user_id] = ownership1.user.id
      delete :destroy, :project_id => ownership1.project.id, :id => task1.id
      expect(response).to redirect_to(project_tasks_path(ownership1.project))
    end

    it "logged in owners of can't delete another owners tasks" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      task1 = create_task(:project => ownership1.project)
      session[:user_id] = ownership2.user.id
      delete :destroy, :project_id => ownership1.project.id, :id => task1.id
      expect(response.status).to eq(404)
    end

    it "admin can destroy a task" do
      ownership1 = create_ownership
      task1 = create_task(:project => ownership1.project)
      user1 = create_super_user
      session[:user_id] = user1.id
      delete :destroy, :project_id => ownership1.project.id, :id => task1.id
      expect(response).to redirect_to(project_tasks_path(ownership1.project))
    end
  end

end
