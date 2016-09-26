# == Schema Information
#
# Table name: customer_orders
#
#  id                      :integer          not null, primary key
#  status                  :integer          default(0), not null
#  subtotal_items_cents    :integer          default(0), not null
#  subtotal_items_currency :string           default("USD"), not null
#  customer_profile_id     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

FactoryGirl.define do
  factory :customer_order do
    customer_profile

    status :in_progress # default
  end
end
