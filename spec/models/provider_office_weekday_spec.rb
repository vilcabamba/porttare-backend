# == Schema Information
#
# Table name: provider_office_weekdays
#
#  id                 :integer          not null, primary key
#  provider_office_id :integer          not null
#  day                :string           not null
#  hora_de_apertura   :time
#  hora_de_cierre     :time
#  abierto            :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe ProviderOfficeWeekday,
               type: :model do
  describe "factory" do
    subject { build :provider_office_weekday }
    it { is_expected.to be_valid }
  end
end
