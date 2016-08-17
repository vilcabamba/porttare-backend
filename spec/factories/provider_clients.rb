# == Schema Information
#
# Table name: provider_clients
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer
#  notes               :text
#  ruc                 :string
#  name                :string
#  address             :string
#  phone               :string
#  email               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :provider_client do
    provider_profile

    notes        { Faker::Company.catch_phrase }
    ruc          { Faker::Code.isbn }
    name         { Faker::Company.name }
    address      { Faker::Address.street_address }
    phone        { Faker::PhoneNumber.phone_number }
    email        { Faker::Internet.email }
  end
end
