require 'rails_helper'

RSpec.describe "reminders/show", type: :view do
  let!(:user) { create(:user) }

  before do
    @reminder = assign(:reminder, create(:reminder, user: user))
  end

  it "renders attributes in <p>" do
    assign(:current_user, user)
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/15:14:17/)
  end
end
