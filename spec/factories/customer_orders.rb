# == Schema Information
#
# Table name: customer_orders
#
#  id                                  :integer          not null, primary key
#  status                              :integer          default(0), not null
#  subtotal_items_cents                :integer          default(0), not null
#  subtotal_items_currency             :string           default("USD"), not null
#  customer_profile_id                 :integer
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  delivery_method                     :integer
#  forma_de_pago                       :integer
#  observaciones                       :text
#  customer_address_attributes         :text
#  customer_billing_address_attributes :text
#  customer_address_id                 :integer
#  customer_billing_address_id         :integer
#

FactoryGirl.define do
  factory :customer_order do
    customer_profile

    status :in_progress # default

    trait :submitted do
      status :submitted
    end
  end
end
