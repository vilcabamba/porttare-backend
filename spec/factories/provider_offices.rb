# == Schema Information
#
# Table name: provider_offices
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer          not null
#  enabled             :boolean          default(FALSE)
#  direccion           :string           not null
#  ciudad              :string
#  horario             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :provider_office do
    provider_profile
    ciudad    { Faker::Address.city }
    horario   "10:00 AM - 7:00 PM"
    direccion { Faker::Address.street_address }

    trait :enabled do
      enabled true
    end
  end
end
