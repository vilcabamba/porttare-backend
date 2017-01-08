# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  lat        :string
#  lon        :string
#  nombre     :string           not null
#  country    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :place do
    lat     { Faker::Address.latitude }
    lon     { Faker::Address.longitude }
    nombre  { Faker::Address.city }
    country "Ecuador"
  end
end
