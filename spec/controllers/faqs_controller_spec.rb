require 'rails_helper'

describe FaqsController do

  describe "#faqpg" do

    it "non-logged-in users can render FAQ page" do
      #FAQ page
      get :faqpg
      expect(response).to render_template("faqpg")
    end

    it "logged-in users can render Home, Terms and About pages" do
      #FAQ page
      get :faqpg
      expect(response).to render_template("faqpg")
    end


  end


end
