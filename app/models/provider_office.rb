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
#  ciudad              :string
#

require "porttare_backend/places"

class ProviderOffice < ActiveRecord::Base
  extend Enumerize

  CIUDADES = PorttareBackend::Places.all

  has_paper_trail

  begin :relationships
    belongs_to :provider_profile
    has_many :provider_dispatchers,
             dependent: :destroy
    has_many :weekdays,
             class_name: "ProviderOfficeWeekday",
             dependent: :destroy
  end

  begin :validations
    validates :direccion,
              presence: true
    validates :ciudad,
              allow_blank: true,
              inclusion: { in: CIUDADES }
    validate :validate_right_weekdays
  end

  enumerize :ciudad, in: CIUDADES

  scope :enabled, -> { where(enabled: true) }

  accepts_nested_attributes_for(
    :weekdays
  )

  ##
  # builds default weekdays
  def build_weekdays
    ProviderOfficeWeekday::DAY_NAMES.map do |wday|
      weekdays.build(day: wday)
    end
  end

  private

  def validate_right_weekdays
    right_length = weekdays.length == ProviderOfficeWeekday::DAY_NAMES.length
    if !right_length || !all_weekdays_included?
      errors.add(:base, :wrong_weekdays)
    end
  end

  def all_weekdays_included?
    ProviderOfficeWeekday::DAY_NAMES.all? do |dayname|
      weekdays.any? do |weekday|
        weekday.day == dayname
      end
    end
  end
end
