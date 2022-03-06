require 'rails_helper'

RSpec.describe "reminders/new", type: :view do
  let!(:user) { create(:user) }

  before(:each) do
    assign(:reminder, build(:reminder, user: user))
  end

  it "renders new reminder form" do
    assign(:current_user, user)
    render
    assert_select "form[action=?][method=?]", reminders_path, "post" do
      assert_select "input[name=?]", "reminder[title]"
      assert_select "textarea[name=?]", "reminder[body]"
      assert_select "input[name=?]", "reminder[user_id]"
      assert_select "select[name=?]", "reminder[scheduled_day]"
      assert_select "input[name=?]", "reminder[scheduled_time]"
    end
  end
end
