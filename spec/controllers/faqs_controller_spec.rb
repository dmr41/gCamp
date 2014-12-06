require 'rails_helper'

describe FaqsController do

  describe "#faqpg" do

    it "non-logged-in users can render FAQ page" do
      #FAQ page
      get :faqpg
      expect(response).to render_template("faqpg")
    end

    it "logged-in users can render FAQ page" do
      #FAQ page
      user1 = create_user
      session[:user_id] = user1.id
      get :faqpg
      expect(response).to render_template("faqpg")
    end

    it "admin can render FAQ page" do
      #FAQ page
      user1 = create_super_user
      session[:user_id] = user1.id
      get :faqpg
      expect(response).to render_template("faqpg")
    end

  end


end
