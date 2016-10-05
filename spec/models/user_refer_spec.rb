# == Schema Information
#
# Table name: user_refers
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  guest_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserRefer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
