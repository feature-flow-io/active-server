FactoryBot.define do
  factory :collaborator do
    role { "editor" }
    joined_at { "2021-07-17 15:48:02" }
    user
    account
    token { SecureRandom.urlsafe_base64 }

    trait :owner do
      role { "owner" }
    end

    trait :pending do
      joined_at { nil }
    end
  end
end
