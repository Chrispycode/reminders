require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "must have an email address" do
    expect(build(:user, email: "")).not_to be_valid
  end

  it "must have a password" do
    expect(build(:user, password: "")).not_to be_valid
  end
end
