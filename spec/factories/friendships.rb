FactoryBot.define do
  factory :friendship do
    user_id { Faker::Number.unique.between(from: 1, to: 100) }
    following_id { Faker::Number.unique.between(from: 1, to: 100) }
  end
end
