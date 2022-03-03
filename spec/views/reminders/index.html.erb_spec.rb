require 'rails_helper'

RSpec.describe "reminders/index", type: :view do
  let!(:user) { create(:user) }

  before do
    assign(:reminders, create_list(:reminder, 2, user: user))
  end

  it "renders a list of reminders" do
    assign(:current_user, user)
    render
    assert_select "h5", text: /MyTitle/, count: 2
    assert_select "div.card-text", text: /MyText/, count: 2
    assert_select "small", text: /Scheduled for \d\d \w\w\w \d\d:\d\d/, count: 2
  end
end
