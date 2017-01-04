# == Schema Information
#
# Table name: shipping_requests
#
#  id                 :integer          not null, primary key
#  resource_id        :integer          not null
#  resource_type      :string           not null
#  kind               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  status             :string           default("new"), not null
#  address_attributes :json
#  courier_profile_id :integer
#  reason             :string
#

FactoryGirl.define do
  factory :shipping_request do
    resource { build :provider_profile }
    kind     { ShippingRequest.kind.values.sample }
  end
end
