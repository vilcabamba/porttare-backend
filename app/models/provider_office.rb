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
#  ciudad              :integer
#

require "porttare_backend/places"

class ProviderOffice < ActiveRecord::Base
  extend Enumerize
  extend IntegersEnumerable

  CIUDADES = integers_enumerable(PorttareBackend::Places.all)
  DAY_NAMES = integers_enumerable(Date::ABBR_DAYNAMES.map(&:downcase))

  has_paper_trail

  begin :relationships
    belongs_to :provider_profile
    has_many :provider_dispatchers,
             dependent: :destroy
  end

  begin :validations
    validates :direccion,
              :hora_de_apertura,
              :hora_de_cierre,
              :telefono,
              presence: true
    validates :inicio_de_labores,
              :final_de_labores,
              allow_blank: true,
              inclusion: { in: DAY_NAMES }
    validates :ciudad,
              allow_blank: true,
              inclusion: { in: CIUDADES }
  end

  enumerize :ciudad, in: CIUDADES
  enumerize :final_de_labores, in: DAY_NAMES
  enumerize :inicio_de_labores, in: DAY_NAMES

  scope :enabled, -> { where(enabled: true) }

  [
    :hora_de_cierre,
    :hora_de_apertura
  ].each do |attribute_name|
    define_method "#{attribute_name}=" do |new_time|
      ##
      # support setting schedule with custom format:
      schedule_format = I18n.t("time.formats.office_schedule")
      send(
        :write_attribute,
        attribute_name,
        DateTime.strptime(new_time, schedule_format)
      )
    end
  end
end
