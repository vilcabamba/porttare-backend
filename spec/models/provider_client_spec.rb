# == Schema Information
#
# Table name: provider_clients
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer
#  notes               :text
#  ruc                 :string
#  name                :string
#  address             :string
#  phone               :string
#  email               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe ProviderClient, type: :model do
  describe "factory" do
    subject { build :provider_client }
    it { is_expected.to be_valid }
  end
end
