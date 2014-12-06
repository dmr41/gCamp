require 'rails_helper'
require 'spec_helper'
  describe UsersController do

    describe "index" do
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
      it "visitors can not render show page of a user" do
        user1 = create_user
        get :show, :id => "#{user1.id}"
        expect(response).to redirect_to(sign_in_path)
      end

      it "logged in user can render show page" do
        user1 = create_user
        session[:user_id] = user1.id
        get :show, :id => "#{user1.id}"
        expect(response).to render_template(:show)
      end

      it "logged in user can render another persons show page" do
        user1 = create_user
        user2 = create_user
        session[:user_id] = user1.id
        get :show, :id => "#{user2.id}"
        expect(response).to render_template(:show)
      end

      it "logged in admin can render any persons show page" do
        user1 = create_super_user
        user2 = create_user
        session[:user_id] = user1.id
        get :show, :id => "#{user2.id}"
        expect(response.status).to render_template(:show)
      end
    end

    describe "#edit" do
      it "visitors can not render edit page of a user" do
        user1 = create_user
        get :show, :id => "#{user1.id}"
        expect(response).to redirect_to(sign_in_path)
      end

      it "logged in user can render edit page" do
        user1 = create_user
        session[:user_id] = user1.id
        get :edit, id: "#{user1.id}"
        expect(response).to render_template(:edit)
      end

      it "logged in user can render another persons edit page" do
        user1 = create_user
        user2 = create_user
        session[:user_id] = user1.id
        get :edit, :id => "#{user2.id}"
        expect(response.status).to eq(404)
      end

      it "logged in admin can render any persons edit page" do
        user1 = create_super_user
        user2 = create_user
        session[:user_id] = user1.id
        get :edit, :id => "#{user2.id}"
        expect(response.status).to render_template(:edit)
      end
    end

    describe "#update" do
      it "visitors can not update exisiting user information" do
        user1 = create_user
        post :update, id: user1.id, user: { first_name: "jehova" }
        expect(response.status).to redirect_to(sign_in_path)
      end

      it "users can update exisiting information about themeselves" do
        user1 = create_user
        session[:user_id] = user1.id
        put :update, id: user1.id, :user => { first_name: "jehova" }
        expect(response).to redirect_to(users_path)
      end

      it "users can not update exisiting information about other users" do
        user1 = create_user
        user2 = create_user
        session[:user_id] = user1.id
        post :update, id: user2.id, user: { first_name: "jehova" }
        expect(response.status).to eq(404)
      end

      it "admin can update exisiting information about anyone" do
        user1 = create_super_user
        user2 = create_user
        session[:user_id] = user1.id
        post :update, id: user2.id, :user => { first_name: "jehova"}
        expect(response).to redirect_to(users_path)
      end
    end

    describe "#create" do
      it "visitors can not create a user without signing up" do
        user1 = create_user
        post :create, :user => { first_name: "jehova", last_name: "witness", email: "a@a.com", password: "a", admin: false }
        expect(response).to redirect_to(sign_in_path)
      end

      it "users can create a new user" do
        user1 = create_user
        session[:user_id] = user1.id
        post :create, :user => { first_name: "jehova", last_name: "witness", email: "a@a.com", password: "a", admin: false }
        expect(response).to redirect_to(users_path)
      end

      it "admin can create a new user" do
        user1 = create_super_user
        session[:user_id] = user1.id
        post :create, :user => { first_name: "jehova", last_name: "witness", email: "a@a.com", password: "a", admin: false }
        expect(response).to redirect_to(users_path)
      end
    end

    describe "#destroy" do
      it "users can delete themselves" do
        user1 = create_user
        delete :destroy, :id => user1.id
        #expect(response).to redirect_to(users_path)
        expect(response).to redirect_to(sign_in_path)
      end

      it "users can delete themselves" do
        user1 = create_user
        session[:user_id] = user1.id
        delete :destroy, :id => "#{user1.id}"
        expect(response).to redirect_to(sign_in_path)
      end

      it "users can not delete other users" do
        user1 = create_user
        user2 = create_user
        session[:user_id] = user1.id
        delete :destroy, :id => "#{user2.id}"
        expect(response.status).to eq(404)
      end

      it "admins can delete other anyone" do
        user1 = create_super_user
        user2 = create_user
        session[:user_id] = user1.id
        delete :destroy, :id => "#{user2.id}"
        expect(response).to redirect_to(users_path)
      end
    end

  end
