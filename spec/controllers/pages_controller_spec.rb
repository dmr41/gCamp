require 'rails_helper'

  describe PagesController do

    describe "#index" do
      it "non-logged-in users can render Homepage" do
        #Homepage
        get :index
        expect(response).to render_template("index")
      end

      it "logged-in users can render Homepage" do
        #Homepage
        user = create_user
        session[:user_id] = user.id
        get :index
        expect(response).to render_template("index")
      end
    end

      describe "#index" do
        it "non-logged-in users can render Terms page" do
          #Terms
          get :cond_pg
          expect(response).to render_template("cond_pg")
        end

        it "logged-in users can render Terms page" do
          #Terms
          user = create_user
          session[:user_id] = user.id
          get :cond_pg
          expect(response).to render_template("cond_pg")
        end
      end

      describe "#info_pg" do
        it "non-logged-in users can render Home, Terms and About pages" do
          #About
          get :info_pg
          expect(response).to render_template("info_pg")
        end

        it "logged-in users can render About page" do
          #About
          user = create_user
          session[:user_id] = user.id
          get :info_pg
          expect(response).to render_template("info_pg")
        end
      end

  end
