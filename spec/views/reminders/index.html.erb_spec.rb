require 'rails_helper'

RSpec.describe "reminders/index", type: :view do
  let!(:user) { create(:user) }

  before do
    assign(:reminders, create_list(:reminder, 2, user: user))
  end

  it "renders a list of reminders" do
    assign(:current_user, user)
    render
    assert_select "p", text: /MyTitle/, count: 2
    assert_select "p", text: /MyText/, count: 2
    assert_select "p", text: /2/, count: 2
    assert_select "p", text: /15:14:17/, count: 2
  end
end
