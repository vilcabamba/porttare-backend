# == Schema Information
#
# Table name: shipping_requests
#
#  id                 :integer          not null, primary key
#  resource_id        :integer          not null
#  resource_type      :string           not null
#  kind               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  status             :string           default("new"), not null
#  address_attributes :json
#  courier_profile_id :integer
#

class ShippingRequest < ActiveRecord::Base
  extend Enumerize

  STATUSES = [
    :new,
    :assigned,
    :in_progress, # or phase1 & phase2
    :delivered
  ].freeze
  KINDS = [
    :ask_to_validate
  ].freeze

  belongs_to :resource, polymorphic: true

  has_paper_trail

  enumerize :kind, in: KINDS
  enumerize :status,
            in: STATUSES,
            scope: true

  validates :resource,
            :kind,
            :status,
            presence: true
end
