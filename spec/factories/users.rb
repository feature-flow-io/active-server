FactoryBot.define do
  factory :user, aliases: %i[creator] do
    first_name { "John" }
    last_name { "Doe" }
    sequence(:email) { |n| "john@example#{n}.com" }
    password { "secret_password" }
    auth_token { SecureRandom.urlsafe_base64 }
    admin { false }
  end
end
