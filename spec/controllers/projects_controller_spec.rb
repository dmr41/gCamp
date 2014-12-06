require 'rails_helper'

describe  ProjectsController do

  describe '#index' do
    it "non-logged in user can not render index" do
      get :index
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged in user can render index" do
      user1 = create_user
      session[:user_id] = user1.id
      get :index
      expect(response).to render_template(:index)
    end

    it "logged in admin can render index" do
      user1 = create_super_user
      session[:user_id] = user1.id
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "non-logged in user can not render new view" do
      get :new
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged in user can render new view" do
      user1 = create_user
      session[:user_id] = user1.id
      get :new
      expect(response).to render_template(:new)
    end

    it "logged in admin can render new view" do
      user1 = create_super_user
      session[:user_id] = user1.id
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe "#show" do
    it "visitors can not render a project show page" do
      membership1 = create_membership
      get :show, :id => membership1.project.id
      expect(response).to redirect_to(sign_in_path)
    end

    it "logged in members of a project can render the project show page" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      get :show, :id => membership1.project.id
      expect(response).to render_template(:show)
    end

    it "logged in user can not render another persons project show page" do
      membership1 = create_membership
      membership2 = create_membership
      session[:user_id] = membership1.user.id
      #render self projects
      get :show, :id => membership1.project.id
      expect(response).to render_template(:show)
      #but not other projects they are not members of
      get :show, :id => membership2.project.id
      expect(response.status).to eq(404)
    end
    #
    it "admin can render any persons project show page" do
      membership1 = create_membership
      membership2 = create_membership
      user2 = create_super_user
      session[:user_id] = user2.id
      get :show, :id => membership1.project.id
      expect(response).to render_template(:show)
      get :show, :id => membership2.project.id
      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do
    it "visitors can not render project edit pages" do
      membership1 = create_membership
      user1 = create_user
      get :edit, id: "#{membership1.project.id}"
      expect(response).to redirect_to(sign_in_path)
    end

    it "member can not render project edit page they don't belong to" do
      membership1 = create_membership
      user1 = create_user
      session[:user_id] = user1.id
      get :edit, id: "#{membership1.project.id}"
      expect(response.status).to eq(404)
    end

    it "owner of one project can not render project edit page they don't belong to" do
      membership1 = create_membership
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      get :edit, id: "#{membership1.project.id}"
      expect(response.status).to eq(404)
    end

    it "project owners can render project edit page they belong to" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      get :edit, id: "#{ownership1.project.id}"
      expect(response).to render_template(:edit)
    end

    it "project members can not render project edit page" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      get :edit, id: "#{membership1.project.id}"
      expect(response.status).to eq(404)
    end

    it "admin can render any project edit page" do
      membership1 = create_membership
      ownership1 = create_ownership
      user1 = create_super_user
      session[:user_id] = user1.id
      get :edit, id: "#{membership1.project.id}"
      expect(response).to render_template(:edit)
      get :edit, id: "#{ownership1.project.id}"
      expect(response).to render_template(:edit)
    end
  end

  describe "#create" do
    it "visitors can not create a project without signing up" do
      membership1 = create_membership
      post :create, :project => { name: "projy"}
      expect(response).to redirect_to(sign_in_path)
    end

    it "a member can create a new project" do
      membership1 = create_membership
      session[:user_id] = membership1.user.id
      post :create, :project => { name: "projy"}
      expect(response).to redirect_to(project_tasks_path(membership1.project.id+1))
    end

    it "an owner or admin can create a new project" do
      ownership1 = create_ownership
      session[:user_id] = ownership1.user.id
      post :create, :project => { name: "projy"}
      expect(response).to redirect_to(project_tasks_path(ownership1.project.id+1))
    end
  end

  describe "#update" do

  end

  describe "#destroy"

  end

end
