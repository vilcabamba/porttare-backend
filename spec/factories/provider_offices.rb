# == Schema Information
#
# Table name: provider_offices
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer          not null
#  enabled             :boolean          default(FALSE)
#  direccion           :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  telefono            :string
#  ciudad              :string
#

require "porttare_backend/places"

FactoryGirl.define do
  factory :provider_office do
    provider_profile

    direccion { Faker::Address.street_address }
    ciudad    { PorttareBackend::Places.all.sample }
    telefono  { Faker::PhoneNumber.phone_number }

    after(:build) do |provider_office|
      ProviderOfficeWeekday::DAY_NAMES.each do |dayname|
        provider_office.weekdays.build(
          attributes_for(:provider_office_weekday).merge(
            day: dayname
          )
        )
      end
    end

    trait :enabled do
      enabled true
    end
  end
end
