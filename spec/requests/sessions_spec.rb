require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:valid_attributes) {
    {
      email: "email@example.com",
      password: "badpassword",
    }
  }

  let(:invalid_attributes) {
    {
      email: "email@example.com",
      password: "nopassword"
    }
  }

  before do
    create(:user, valid_attributes.merge({password_confirmation: "badpassword"}))
  end

  describe "GET /new" do
    it "renders a successful response" do
      get login_url
      expect(response).to be_successful
    end
  end

  describe "POST /login" do
    context "with valid parameters" do
      it "creates a new session and redirects to root" do
        post login_url, params: { login: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'new' template)" do
        post login_url, params: { login: invalid_attributes }
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
