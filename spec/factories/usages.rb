FactoryBot.define do
  factory :usage do
    user_id { Faker::Number.unique.between(from: 1, to: 100) }
    kwh { Faker::Number.between(from: 1000, to: 3000) }
    start_date { Faker::Date.unique.backward(days: 15) }
    end_date { Faker::Date.unique.forward(days: 15) }
    meter_id { Faker::Number.unique.between(from: 1, to: 1000) }
  end
end
