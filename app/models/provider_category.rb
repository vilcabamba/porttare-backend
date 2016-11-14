# == Schema Information
#
# Table name: provider_categories
#
#  id          :integer          not null, primary key
#  titulo      :string           not null
#  imagen      :string
#  descripcion :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProviderCategory < ActiveRecord::Base
  validates :titulo,
            presence: true,
            uniqueness: true
  has_many :provider_profiles
  mount_uploader :imagen, ProviderCategoryImageUploader
end
