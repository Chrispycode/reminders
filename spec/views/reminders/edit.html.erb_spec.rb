require 'rails_helper'

RSpec.describe "reminders/edit", type: :view do
  let!(:user) { create(:user) }

  before do
    @reminder = assign(:reminder, create(:reminder, user: user))
  end

  it "renders the edit reminder form" do
    assign(:current_user, user)
    render
    assert_select "form[action=?][method=?]", reminder_path(@reminder), "post" do
      assert_select "input[name=?]", "reminder[title]"
      assert_select "textarea[name=?]", "reminder[body]"
      assert_select "input[name=?]", "reminder[user_id]"
      assert_select "select[name=?]", "reminder[scheduled_day]"
      assert_select "select[name=?]", "reminder[scheduled_time(4i)]"
      assert_select "select[name=?]", "reminder[scheduled_time(5i)]"
    end
  end
end
