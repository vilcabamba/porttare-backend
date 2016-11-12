# == Schema Information
#
# Table name: customer_addresses
#
#  id                  :integer          not null, primary key
#  ciudad              :string
#  parroquia           :string
#  barrio              :string
#  direccion_uno       :string
#  direccion_dos       :string
#  codigo_postal       :string
#  referencia          :text
#  numero_convencional :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_profile_id :integer          not null
#  nombre              :string
#

require 'rails_helper'

RSpec.describe CustomerAddress,
               type: :model do
  describe "factory" do
    subject { build :customer_address }
    it { is_expected.to be_valid }
  end
end
