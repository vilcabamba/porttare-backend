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
#  reason             :string
#

class ShippingRequest < ActiveRecord::Base
  extend Enumerize

  STATUSES = [
    :new,
    :assigned,
    :in_progress, # or phase1 & phase2
    :delivered,
    :canceled
  ].freeze
  KINDS = [
    :ask_to_validate,
    :customer_order_delivery
  ].freeze

  belongs_to :resource, polymorphic: true

  has_paper_trail

  enumerize :kind,
            in: KINDS,
            scope: true,
            i18n_scope: "shipping_request.kinds"
  enumerize :status,
            in: STATUSES,
            scope: true,
            i18n_scope: "shipping_request.statuses"

  ##
  # resource may be the provider we need to validate
  # resource may be what we're delivering (customer_order)
  validates :resource,
            :kind,
            :status,
            presence: true

  def provider_profile
    # TODO this should be perhaps another relationship
    resource
  end
end
