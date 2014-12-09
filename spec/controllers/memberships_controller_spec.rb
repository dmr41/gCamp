require 'rails_helper'

describe  MembershipsController do

  describe '#index' do
    it "non logged in user can't access memberships index for a project" do
      membership1 = create_membership
      get :index, {:project_id => membership1.project.id}
      expect(response).to redirect_to(sign_in_path)
    end


    it "a logged in member can access memberships index for a project" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      get :index, {:project_id => membership1.project.id}
      expect(response).to render_template(:index)
    end

    it "a logged in owner can access the memberships index for a project" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      get :index, {:project_id => ownership1.project.id}
      expect(response).to render_template(:index)
    end

    it "a logged in owner can't access the memberships index for other project they aren't members of" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      session[:user_id] = ownership2.user.id
      get :index, {:project_id => ownership1.project.id}
      expect(response.status).to eq(404)
    end

    it "admin can access the memberships index for any project" do
      ownership1 = create_ownership
      user1 = create_super_user
      session[:user_id] = user1.id
      get :index, {:project_id => ownership1.project.id}
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    it "logged in members can view show page of memberships" do
      membership1 = create_membership
      user1 = create_user
      session[:user_id] = user1.id
      get :show, {:project_id => membership1.project.id, :id => membership1.id}
      expect(response.status).to eq(404)
    end

    it "logged in members can view show page of memberships" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      get :show, {:project_id => membership1.project.id, :id => membership1.id}
      expect(response).to render_template(:show)
    end

    it "logged in members can not view membership show pages they are connected to" do
      membership1 = create_membership
      membership2 = create_membership
      session[:user_id] = membership2.user.id
      get :show, {:project_id => membership1.project.id, :id => membership1.id}
      expect(response.status).to eq(404)
    end

    it "logged in owners can view show page of memberships" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      get :show, {:project_id => ownership1.project.id, :id => ownership1.id}
      expect(response).to render_template(:show)
    end

    it "logged in owners can not view membership show pages they are connected to" do
      ownership1 = create_ownership
      ownership2 = create_ownership
      session[:user_id] = ownership2.user.id
      get :show, {:project_id => ownership1.project.id, :id => ownership1.id}
      expect(response.status).to eq(404)
    end

    it "admin can view membership show pages of anyone" do
      membership1 = create_membership
      ownership1 = create_ownership
      user1 = create_super_user
      session[:user_id] = user1.id
      get :show, {:project_id => membership1.project.id, :id => membership1.id}
      expect(response).to render_template(:show)
      get :show, {:project_id => ownership1.project.id, :id => ownership1.id}
      expect(response).to render_template(:show)
    end
  end
  it "non-logged in visitors can't create a task" do
    membership1 = create_membership
    task1 = create_task(project: membership1.project)
    post :create, :project_id => membership1.project.id, :task => {description: "stuff", complete: false}
    expect(response).to redirect_to(sign_in_path)
  end
  describe '#update' do
    it "logged in owners of a project can update a member" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      put :update, :project_id => ownership1.project.id, :id => ownership1.id, :membership => {role: "Owner"}
      expect(response).to redirect_to(project_memberships_path(ownership1.project))
    end

    it "logged in members of a project can not update a member" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      put :update, :project_id => membership1.project.id, :id => membership1.id, :membership => {role: "Member"}
      expect(response.status).to eq(404)
    end

    it "logged in owners of a project can update a member" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      put :update, :project_id => ownership1.project.id, :id => ownership1.id, :membership => {role: "Owner"}
      expect(response).to redirect_to(project_memberships_path(ownership1.project))
    end
  end


end
