require 'rails_helper'

  describe AuthenticationController do

    describe "#new" do

      it " a new view is displayed for for user to log in" do
        get :new
        expect(response).to render_template("new")
      end

    end


  end
