# == Schema Information
#
# Table name: customer_profiles
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  fecha_de_nacimiento :date
#  ciudad              :string
#

FactoryGirl.define do
  factory :customer_profile do
    user
    ciudad              { Faker::Address.city }
    fecha_de_nacimiento { Faker::Date.birthday }
  end
end
