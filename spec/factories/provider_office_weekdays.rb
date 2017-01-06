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

FactoryGirl.define do
  factory :provider_office_weekday do
    provider_office

    day              "mon"
    # GMT-5 is ecuadorian time
    hora_de_cierre   "19:00 -0500"
    hora_de_apertura "10:00 -0500"
    abierto          true
  end
end
