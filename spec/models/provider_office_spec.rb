# == Schema Information
#
# Table name: provider_offices
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer          not null
#  enabled             :boolean          default(FALSE)
#  direccion           :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  telefono            :string
#  hora_de_apertura    :time
#  hora_de_cierre      :time
#  inicio_de_labores   :integer
#  final_de_labores    :integer
#  ciudad              :string
#

require 'rails_helper'

RSpec.describe ProviderOffice,
               type: :model do
  describe "factory" do
    subject { build :provider_office }
    it { is_expected.to be_valid }
  end

  describe "allows setting schedule with timezone" do
    let(:provider_office) {
      create :provider_office,
              hora_de_cierre: '23:00 -0500'
    }
    it {
      expect(
        provider_office.hora_de_cierre
      ).to be_a(DateTime)

      expect(
        provider_office.hora_de_cierre.strftime("%H:%M %z")
      ).to eq("23:00 -0500")
    }
  end

  describe "validates labor days" do
    subject { build :provider_office }
    describe "valid" do
      before {
        subject.inicio_de_labores = "tue"
      }
      it {
        is_expected.to be_valid
        expect(subject.inicio_de_labores).to be_tue
      }
    end

    describe "invalid" do
      before {
        subject.final_de_labores = 'Enero'
      }
      it { is_expected.to_not be_valid }
    end
  end
end
