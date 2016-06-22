FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@noggalito.com" }
    sequence(:password) { |n| "user-password-#{n}" }
    password_confirmation { password }
  end
end
