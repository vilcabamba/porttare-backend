# == Schema Information
#
# Table name: shipping_requests
#
#  id            :integer          not null, primary key
#  resource_id   :integer          not null
#  resource_type :string           not null
#  kind          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :shipping_request do
    resource { build_stubbed :provider_profile }
    kind     { ShippingRequest.kind.values.sample }
  end
end
