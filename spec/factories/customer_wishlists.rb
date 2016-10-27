# == Schema Information
#
# Table name: customer_wishlists
#
#  id                  :integer          not null, primary key
#  customer_profile_id :integer          not null
#  nombre              :string           not null
#  provider_items_ids  :text             default([]), is an Array
#  entregar_en         :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :customer_wishlist do
    customer_profile

    nombre          { Faker::Hipster.sentence }
    entregar_en     { Faker::Time.forward }
    provider_items_ids []
  end
end
