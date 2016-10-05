# == Schema Information
#
# Table name: customer_order_items
#
#  id                            :integer          not null, primary key
#  customer_order_id             :integer          not null
#  provider_item_id              :integer          not null
#  provider_item_precio_cents    :integer
#  provider_item_precio_currency :string           default("USD"), not null
#  cantidad                      :integer          default(1), not null
#  observaciones                 :text
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

FactoryGirl.define do
  factory :customer_order_item do
    customer_order
    provider_item

    cantidad      { 1.upto(10).to_a.sample }
    observaciones { Faker::Hipster.paragraphs.join "\n" }
  end
end
