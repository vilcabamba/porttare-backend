# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  nickname               :string
#  image                  :string
#  email                  :string
#  info                   :json
#  credentials            :json
#  tokens                 :json
#  created_at             :datetime
#  updated_at             :datetime
#

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@noggalito.com" }
    sequence(:password) { |n| "user-password-#{n}" }
    password_confirmation { password }

    trait :provider do
      after :create do |user|
        create :provider_profile, user: user
      end
    end
  end
end
