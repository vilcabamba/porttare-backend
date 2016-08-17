# == Schema Information
#
# Table name: provider_clients
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer
#  notes               :text
#  ruc                 :string
#  name                :string
#  address             :string
#  phone               :string
#  email               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ProviderClient < ActiveRecord::Base
  #relationships
  belongs_to :provider_profile

  #validations
  validates :provider_profile_id,
            :ruc,
            :name,
            :address,
            :phone,
            :email,
            presence: true

  validates :ruc, uniqueness: true

end
