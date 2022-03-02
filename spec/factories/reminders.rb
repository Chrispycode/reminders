FactoryBot.define do
  factory :reminder do
    title { "MyTitle" }
    body { "MyText" }
    user { create(:user) }
    scheduled_time { "15:14:17" }
    scheduled_day { 1 }
  end
end
