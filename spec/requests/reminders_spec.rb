require 'rails_helper'

RSpec.describe "/reminders", type: :request do

  before do
    login
  end

  let(:valid_attributes) {
    {
      title: "MyString",
      body: "MyText",
      user_id: User.first.id,
      scheduled_time: Time.current.strftime("%H:%M"),
      scheduled_day: 1
    }
  }

  let(:invalid_attributes) {
      {
        title: "MyString",
        body: "MyText",
        user_id: nil,
        scheduled_time: Time.current.strftime("%H:%M"),
        scheduled_day: 1
      }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Reminder.create! valid_attributes
      get root_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_reminder_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      reminder = Reminder.create! valid_attributes
      get edit_reminder_url(reminder)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Reminder" do
        expect {
          post reminders_url, params: { reminder: valid_attributes }
        }.to change(Reminder, :count).by(1)
      end

      it "redirects to the created reminder" do
        post reminders_url, params: { reminder: valid_attributes }
        expect(response).to redirect_to(edit_reminder_url(Reminder.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Reminder" do
        expect {
          post reminders_url, params: { reminder: invalid_attributes }
        }.to change(Reminder, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post reminders_url, params: { reminder: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: "NewString",
          body: "NewText"
        }
      }

      it "updates the requested reminder" do
        reminder = Reminder.create! valid_attributes
        patch reminder_url(reminder), params: { reminder: new_attributes }
        reminder.reload
      end

      it "redirects to the reminder" do
        reminder = Reminder.create! valid_attributes
        patch reminder_url(reminder), params: { reminder: new_attributes }
        reminder.reload
        expect(response).to redirect_to(edit_reminder_url(reminder))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        reminder = Reminder.create! valid_attributes
        patch reminder_url(reminder), params: { reminder: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested reminder" do
      reminder = Reminder.create! valid_attributes
      expect {
        delete reminder_url(reminder)
      }.to change(Reminder, :count).by(-1)
    end

    it "redirects to the reminders list" do
      reminder = Reminder.create! valid_attributes
      delete reminder_url(reminder)
      expect(response).to redirect_to(reminders_url)
    end
  end
end
