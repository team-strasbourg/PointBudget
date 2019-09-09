FactoryBot.define do
  factory :user do
    email { Faker::Internet.email}
    password { Faker::Internet.password}
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    phone_number { %w(0606060606 +33606060606).sample}

    factory :user_empty_email do
      email {""}
    end
    factory :user_bad_email do
      email {"sdf"}
    end
    factory :user_empty_password do
      password {""}
    end
    factory :user_bad_password do
      password {"sdf"}
    end
    factory :user_empty_phone do
      phone_number {""}
    end
    factory :user_bad_phone do
      phone_number {"0606"}
    end
  end
end
