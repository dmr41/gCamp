require 'rails_helper'


  describe AuthenticationController do

    before do
      cleanup_databases
    end

    describe "#new" do
      it " a new view is displayed for for user to log in" do
        get :new
        expect(response).to render_template("new")
      end

    end

    describe "#create" do
      it "existing users can sign_in" do
        user1 = create_user
        post :create, email: user1.email, password: user1.password
        expect(response).to redirect_to(projects_path)
      end

      it "existing users can't sign_in with wrong email" do
        user1 = create_user
        user2 = create_user
        post :create, email: user1.email, password: user2.password
        expect(response).to render_template(:new)
      end

      it "existing users can't sign_in with no email or password" do
        user1 = create_user
        post :create, email: " ", password: " "
        expect(response).to render_template(:new)
      end

    end

  end
