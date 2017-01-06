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

    final_de_labores {
      ProviderOffice.final_de_labores.values.sample
    }
    inicio_de_labores {
      ProviderOffice.inicio_de_labores.values.sample
    }

    trait :enabled do
      enabled true
    end
  end
end
