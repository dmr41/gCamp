require 'rails_helper'

  describe AuthenticationController do

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
    end

  end
