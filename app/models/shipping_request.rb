# == Schema Information
#
# Table name: shipping_requests
#
#  id            :integer          not null, primary key
#  resource_id   :integer          not null
#  resource_type :string           not null
#  kind          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ShippingRequest < ActiveRecord::Base
  extend Enumerize

  KINDS = [
    :ask_to_validate
  ].freeze

  belongs_to :resource, polymorphic: true

  enumerize :kind, in: KINDS

  validates :resource,
            :kind,
            presence: true
end
