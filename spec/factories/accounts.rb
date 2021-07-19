FactoryBot.define do
  factory :account do
    name { "Example account" }
    sequence(:subdomain) { |n| "example#{n}" }
    cname { "example.example.com" }
    creator
    status { "active" }

    trait :inactive do
      status { "inactive" }
    end
  end
end
