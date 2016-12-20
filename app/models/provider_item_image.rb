# == Schema Information
#
# Table name: provider_item_images
#
#  id               :integer          not null, primary key
#  provider_item_id :integer          not null
#  imagen           :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ProviderItemImage < ActiveRecord::Base
  belongs_to :provider_item
  has_paper_trail

  mount_uploader :imagen, ProviderItemImageUploader

  validates :imagen,
            presence: true,
            if: "imagen_cache.blank?"
end
