require 'rails_helper'

  describe PagesController do

    before do
      cleanup_databases
    end
    
    describe "#index" do
      it "non-logged-in users can render Homepage" do
        #Homepage
        get :index
        expect(response).to render_template("index")
      end

      it "logged-in users can render Homepage" do
        #Homepage
        user1 = create_user
        session[:user_id] = user1.id
        get :index
        expect(response).to render_template("index")
      end

      it "admin can render Homepage" do
        #Homepage
        user1 = create_super_user
        session[:user_id] = user1.id
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
          user1 = create_user
          session[:user_id] = user1.id
          get :cond_pg
          expect(response).to render_template("cond_pg")
        end

        it "admin can render Terms page" do
          #Terms
          user1 = create_user
          session[:user_id] = user1.id
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
          user1 = create_user
          session[:user_id] = user1.id
          get :info_pg
          expect(response).to render_template("info_pg")
        end

        it "admin can render About page" do
          #About
          user1 = create_user
          session[:user_id] = user1.id
          get :info_pg
          expect(response).to render_template("info_pg")
        end
      end

  end
