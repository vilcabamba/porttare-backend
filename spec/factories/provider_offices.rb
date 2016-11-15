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
#  hora_de_apertura    :time
#  hora_de_cierre      :time
#  inicio_de_labores   :integer
#  final_de_labores    :integer
#  ciudad              :integer
#

require "porttare_backend/places"

FactoryGirl.define do
  factory :provider_office do
    provider_profile

    # GMT-5 is ecuadorian time
    hora_de_cierre   "19:00 -0500"
    hora_de_apertura "10:00 -0500"

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
