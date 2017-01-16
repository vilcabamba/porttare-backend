# == Schema Information
#
# Table name: places
#
#  id                  :integer          not null, primary key
#  lat                 :string
#  lon                 :string
#  nombre              :string           not null
#  country             :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  price_per_km_cents  :integer          default(1)
#  factor_per_distance :float            default(0.1)
#

FactoryGirl.define do
  factory :place do
    lat     { Faker::Address.latitude }
    lon     { Faker::Address.longitude }
    nombre  { Faker::Address.city }
    country "Ecuador"
  end
end
