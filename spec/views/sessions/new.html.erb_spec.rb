require 'rails_helper'

RSpec.describe "sessions/new", type: :view do
  it "renders new session form" do
    render

    assert_select "form[action=?][method=?]", login_path, "post" do
      assert_select "input[name=?]", "login[email]"
      assert_select "input[name=?]", "login[password]"
    end
  end
end
