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

FactoryGirl.define do
  factory :user_refer do
    
  end
end
