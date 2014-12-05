require 'rails_helper'

  describe UsersController do

    describe "index" do
      it "non-logged in user can not render index" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end

      it "logged in user can render index" do
        user = create_user
        session[:user_id] = user.id
        get :index
        expect(response).to render_template(:index)
      end

      it "logged in admin can render index" do
        user = create_super_user
        session[:user_id] = user.id
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
        user = create_user
        session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end

      it "logged in admin can render new view" do
        user = create_super_user
        session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "#show" do
      it "visitors can not render show page of a user" do
        user = create_user
        get :show, :id => "#{user.id}"
        expect(response).to redirect_to(sign_in_path)
      end

      it "logged in user can render show page" do
        user = create_user
        session[:user_id] = user.id
        get :show, :id => "#{user.id}"
        expect(response).to render_template(:show)
      end

      it "logged in user can render another persons show page" do
        user = create_user
        user2 = create_user
        session[:user_id] = user.id
        get :show, :id => "#{user2.id}"
        expect(response).to render_template(:show)
      end

      it "logged in admin can render any persons show page" do
        user = create_super_user
        user2 = create_user
        session[:user_id] = user.id
        get :show, :id => "#{user2.id}"
        expect(response.status).to render_template(:show)
      end
    end

    describe "#edit" do
      it "visitors can not render edit page of a user" do
        user = create_user
        get :show, :id => "#{user.id}"
        expect(response).to redirect_to(sign_in_path)
      end

      it "logged in user can render edit page" do
        user = create_user
        session[:user_id] = user.id
        get :edit, id: "#{user.id}"
        expect(response).to render_template(:edit)
      end

      it "logged in user can render another persons edit page" do
        user = create_user
        user2 = create_user
        session[:user_id] = user.id
        get :edit, :id => "#{user2.id}"
        expect(response.status).to eq(404)
      end

      it "logged in admin can render any persons edit page" do
        user = create_super_user
        user2 = create_user
        session[:user_id] = user.id
        get :edit, :id => "#{user2.id}"
        expect(response.status).to render_template(:edit)
      end
    end


  end
