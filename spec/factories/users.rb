FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "example-#{n}@email.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
