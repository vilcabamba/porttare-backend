# == Schema Information
#
# Table name: provider_items
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer
#  titulo              :string           not null
#  descripcion         :text
#  unidad_medida       :integer
#  precio              :money            not null
#  volumen             :string
#  peso                :string
#  imagen              :string
#  observaciones       :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe ProviderItem,
               type: :model do
  describe "factory" do
    subject { build :provider_item }
    it { is_expected.to be_valid }
  end
end
