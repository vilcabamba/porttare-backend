# == Schema Information
#
# Table name: customer_addresses
#
#  id                  :integer          not null, primary key
#  ciudad              :string
#  parroquia           :string
#  barrio              :string
#  direccion_uno       :string
#  direccion_dos       :string
#  codigo_postal       :string
#  referencia          :text
#  numero_convencional :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_profile_id :integer          not null
#  nombre              :string
#

class CustomerAddress < ActiveRecord::Base
  belongs_to :customer_profile
end
