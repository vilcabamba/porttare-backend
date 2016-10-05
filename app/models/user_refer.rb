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

class UserRefer < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest, class_name: "User"
end
