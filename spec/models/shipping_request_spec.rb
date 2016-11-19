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

require 'rails_helper'

RSpec.describe ShippingRequest,
               type: :model do
  describe "factory" do
    let(:provider_profile) { create :provider_profile }
    subject {
      build :shipping_request,
            resource: provider_profile
    }
    it { is_expected.to be_valid }
    it {
      subject.save
      expect(
        subject.reload.resource_id
      ).to eq(provider_profile.id)
      expect(
        subject.reload.resource_type
      ).to eq(provider_profile.class.to_s)
    }
  end
end
