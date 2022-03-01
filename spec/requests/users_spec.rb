require 'rails_helper'

RSpec.describe "/users", type: :request do

  let(:valid_attributes) {
    {
      email: "email@example.com",
      password: "badpassword",
      password_confirmation: "badpassword"
    }
  }

  let(:invalid_attributes) {
    {
      email: "email@example.com",
      password: "badpassword"
    }
  }

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post users_url, params: { user: invalid_attributes }
        expect(response).to redirect_to(new_user_url)
      end
    end
  end
end
