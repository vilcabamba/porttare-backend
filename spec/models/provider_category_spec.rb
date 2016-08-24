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

require 'rails_helper'

RSpec.describe ProviderCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
